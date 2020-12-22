import-module au

$repoUri = 'https://www.touch-portal.com/index.html'

function global:au_GetLatest {
    $repoPage       = Invoke-WebRequest -Uri $repoUri -UseBasicParsing
    $regEx          = '[\S\s]+Setup.exe[\D]+<br>v(.*?)<br>[\S\s]+'
    $releaseVersion = $repoPage.Content -replace $regEx,'$1'

   return @{ 
      Version   = $releaseVersion
   }
}

function global:au_SearchReplace {
    @{
       "tools\chocolateyInstall.ps1"        = @{
        "(^[$]version\s*=\s*)('.*')"        = "`${1} $($Latest.Version)"
       } 
    }
 }

update -ChecksumFor none
