import-module au

$nuspecInfo  = ( [xml] ( Get-Content .\$packageName.nuspec ) ).package.metadata
$repoOwner   = $nuspecInfo.repoOwner
$repoApp     = $nuspecInfo.repoApp
$licenseUrl  = $nuspecInfo.licenseUrl

function global:au_GetLatest {
    $repoPage               = Get-GitHubRelease $repoOwner $repoApp
    $releaseVersion         = ( $repoPage.tag_name ).split( "@" )[ -1 ]
    $releaseUrl64           = ( $repoPage.assets | Where-Object name -like "*win.exe" ).browser_download_url
    $releaseUrlchecksum64   = ( $repoPage.assets | Where-Object name -like "*SHA256SUMS" ).browser_download_url
    $checksumPage           = Invoke-RestMethod -Method GET -Uri $releaseUrlchecksum64 -UseBasicParsing
    $releaseChecksum64      = ( ( ( $checksumPage | Select-String -Pattern "(.*)win.exe" ).Matches.Groups[0].Value ) -split "\s+" )[0]

   return @{ 
      Version        = $releaseVersion
      URL64          = $releaseUrl64
      Checksum64     = $releaseChecksum64
      ChecksumType64 = "sha265"
   }
}

function global:au_SearchReplace {
    @{
       ".\legal\VERIFICATION.txt"                   = @{
        "(?i)(64-Bit software:.+)\<.*\>"            = "`${1}<$($Latest.URL64)>"
        "(?i)(checksum64:).*"                       = "`${1} $($Latest.Checksum64)"
        "(?i)(checksum type:).*"                    = "`${1} $($Latest.ChecksumType64)"
        "(?i)(\s*has been obtained from\s*)\<.*\>"  = "`${1}<$($LicenseUrl)>"
       }
       ".\tools\chocolateyInstall.ps1"              = @{
        "(?i)(^[$]version\s*=\s*)('.*')"            = "`${1}'$($Latest.Version)'"
        "(?i)(^\s*url64bit\s*=\s*)('.*')"           = "`${1}'$($Latest.URL64)'"
        "(?i)(^\s*checksum64\s*=\s*)('.*')"         = "`${1}'$($Latest.Checksum64)'"
       }
    }
 }

 function global:au_AfterUpdate($Package) {
    Invoke-WebRequest $licenseUrl -OutFile .\legal\LICENSE.txt
}

update -ChecksumFor none
