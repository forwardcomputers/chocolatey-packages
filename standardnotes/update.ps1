import-module au
Add-Type -AssemblyName System.Web

$_pkgName   = Split-Path -Leaf $PSScriptRoot
$nuspecInfo = ( [xml] ( Get-Content ".\$_pkgName.nuspec" ) ).package.metadata
$repoOwner  = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -2 ]
$repoApp    = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -1 ]
$repoUri    = [System.Web.HttpUtility]::UrlDecode( "https://api.github.com/repos/$repoOwner/$repoApp/releases/latest" )
$licenseUrl = $nuspecInfo.licenseUrl

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*64-Bit software\:).*"             = "`${1} $($Latest.URL64)"
            "(?i)(^\s*checksum type\:).*"               = "`${1} $($Latest.ChecksumType64)"
            "(?i)(^\s*checksum64\:).*"                  = "`${1} $($Latest.Checksum64)"
            "(?i)(\s*has been obtained from\s*)\<.*\>"  = "`${1}<$($LicenseUrl)>"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]version\s*=\s*)('.*')"            = "`${1}'$($Latest.Version)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"           = "`${1}'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"         = "`${1}'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType64\s*=\s*)('.*')"     = "`${1}'$($Latest.ChecksumType64)'"
       }
    }
}

function global:au_GetLatest {
    $repoPage             = Invoke-RestMethod -Method GET -Uri $repoUri -UseBasicParsing
    $releaseVersion       = ( $repoPage.tag_name ).split( '@' )[ -1 ]
    $releaseUrl64         = [System.Web.HttpUtility]::UrlDecode( ( $repoPage.assets | Where-Object name -like '*win.exe' ).browser_download_url )
    $releaseUrlchecksum64 = [System.Web.HttpUtility]::UrlDecode( ( $repoPage.assets | Where-Object name -like '*SHA256SUMS' ).browser_download_url )
    $checksumPage         = Invoke-RestMethod -Method GET -Uri $releaseUrlchecksum64 -UseBasicParsing
    $releaseChecksum64    = ( ( ( $checksumPage | Select-String -Pattern '(.*)win.exe' ).Matches.Groups[0].Value ) -split '\s+' )[0]

   @{ 
      Version        = $releaseVersion
      URL64          = $releaseUrl64
      Checksum64     = $releaseChecksum64
      ChecksumType64 = 'sha265'
   }
}

function global:au_AfterUpdate($Package) {
    Invoke-WebRequest $licenseUrl -OutFile '.\legal\LICENSE.txt'
}

update -ChecksumFor none
