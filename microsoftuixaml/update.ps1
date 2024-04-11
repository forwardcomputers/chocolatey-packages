import-module au
Add-Type -AssemblyName System.Web

$_pkgName   = Split-Path -Leaf $PSScriptRoot
$nuspecInfo = ( [xml] ( Get-Content ".\$_pkgName.nuspec" ) ).package.metadata
$repoOwner  = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -2 ]
$repoApp    = ( $nuspecInfo.projectSourceUrl ).split( '/' )[ -1 ]
$repoUri    = [System.Web.HttpUtility]::UrlDecode( "https://api.github.com/repos/$repoOwner/terminal/releases/latest" )
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
            "(?i)(^\s*url64bit\s*=\s*)('.*')"           = "`${1}'$($Latest.URL64)'"
       }
    }
}

function global:au_GetLatest {
    $repoPage             = Invoke-RestMethod -Method GET -Uri $repoUri -UseBasicParsing
    $releaseUrl64         = [System.Web.HttpUtility]::UrlDecode( ( $repoPage.assets | Where-Object name -like '*PreinstallKit.zip' ).browser_download_url )

    Get-ChocolateyWebFile -PackageName $_pkgName -FileFullPath "$toolsDir\$_pkgName.zip" -Url $releaseUrl64
    Get-ChocolateyUnzip -FileFullPath "$toolsDir\$_pkgName.zip" -Destination $toolsDir

    $releaseVersion       = ( Get-Item "$toolsDir\*x64*" ).Name -replace '.*UI.Xaml.(.*?)_.*','$1'

    @{ 
      Version        = $releaseVersion
      URL64          = $releaseUrl64
   }
}

function global:au_AfterUpdate($Package) {
    Invoke-WebRequest $licenseUrl -OutFile '.\legal\LICENSE.txt'
}

update -ChecksumFor none
