import-module au
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"

Add-Type -AssemblyName System.Web

$_pkgName   = Split-Path -Leaf $PSScriptRoot
$nuspecInfo = ( [xml] ( Get-Content ".\$_pkgName.nuspec" ) ).package.metadata
$repoOwner  = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -2 ]
$repoApp    = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -1 ]
$repoUri    = [System.Web.HttpUtility]::UrlDecode( "https://github.com/$repoOwner/terminal/raw/main/build/config/template.appinstaller" )
$licenseUrl = $nuspecInfo.licenseUrl
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt"      = @{
            "(?i)(^\s*64-Bit software\:).*"             = "`${1} $($Latest.URL64)"
            "(?i)(\s*has been obtained from\s*)\<.*\>"  = "`${1}<$($LicenseUrl)>"
        }
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^[$]version\s*=\s*)('.*')"            = "`${1}'$($Latest.Version)'"
            "(?i)(^[$]url64bit\s*=\s*)('.*')"           = "`${1}'$($Latest.URL64)'"
       }
    }
}

function global:au_GetLatest {
    [xml]$xamlPage = ( New-Object System.Net.WebClient ).DownloadString( $repoUri )
    $releaseVersion = ( $xamlPage.AppInstaller.Dependencies.ChildNodes | Where-Object { $_.ProcessorArchitecture -eq "x64" } ).name.trimstart( "Microsoft.UI.Xaml." )
    $releaseUrl64 = ( $xamlPage.AppInstaller.Dependencies.ChildNodes | Where-Object { $_.ProcessorArchitecture -eq "x64" } ).Uri

    return @{ 
      Version        = $releaseVersion
      URL64          = $releaseUrl64
   }
}

function global:au_AfterUpdate($Package) {
    Invoke-WebRequest $licenseUrl -OutFile '.\legal\LICENSE.txt'
}

update -ChecksumFor none

