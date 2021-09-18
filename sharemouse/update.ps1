import-module au

$downloadUri = 'https://www.sharemouse.com/download/'
$softwareUri = 'https://www.sharemouse.com/ShareMouseSetup.exe'

function global:au_GetLatest {
    $downloadPage           = Invoke-WebRequest -Uri $downloadUri -UseBasicParsing
    $releaseChangeLog       = $downloadPage.Links | Where-Object { $_.href -eq '/download/changelog/' }
    $regexPattern           = [ Regex ]::new( '(?<=>).+?(?=<)' )
    $releaseVersion         = ( ( $regexPattern.Matches( $releaseChangeLog.outerHTML ) )[ 0 ].value ).ToString()
    $releaseUrl64           = $softwareUri

   return @{ 
      Version       = $releaseVersion
      URL64         = $releaseUrl64
   }
}

function global:au_SearchReplace {
    @{
       ".\tools\chocolateyInstall.ps1"      = @{
        "(?i)(^[$]version\s*=\s*)('.*')"    = "`${1}'$($Latest.Version)'"
        "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`${1}'$($Latest.URL64)'"
       }
       ".\tools\VERIFICATION.txt"           = @{
        "(?i)(\s+x64:).*"                   = "`${1} $($Latest.URL64)"
       }
    }
 }

update -ChecksumFor none
