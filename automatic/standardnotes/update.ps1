import-module au

$repoUri = 'https://api.github.com/repos/standardnotes/desktop/releases/latest'

function global:au_GetLatest {
    $repoPage               = Invoke-RestMethod -Method GET -Uri $repoUri -UseBasicParsing
    $releaseVersion         = ( ( $repoPage ).tag_name ).substring( 1 )
    $releaseUrl64           = ( ( $repoPage ).assets | Where-Object name -like "*win.exe" ).browser_download_url
    $releaseUrlchecksum64   = ( ( $repoPage ).assets | Where-Object name -like "*SHA256SUMS" ).browser_download_url
    $checksumPage           = Invoke-RestMethod -Method GET -Uri $releaseUrlchecksum64 -UseBasicParsing
    $releaseChecksum64      = ( ( ( $checksumPage | Select-String -Pattern "(.*)win.exe" ).Matches.Groups[0].Value ) -split "\s+" )[0]

   return @{ 
      Version       = $releaseVersion
      URL64         = $releaseUrl64
      Checksum64    = $releaseChecksum64
   }
}

function global:au_SearchReplace {
    @{
       'tools\chocolateyInstall.ps1' = @{
        "(^[$]version\s*=\s*)('.*')"        = "`$1'$($Latest.Version)'"
        "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
        "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
       } 
    }
 }

update -ChecksumFor none
