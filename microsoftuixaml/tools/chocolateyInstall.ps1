$ErrorActionPreference = 'Stop'

$version = '3.192.4'

$installedVersion = (Get-AppxPackage | Where-Object { $_.Name -like "*Xaml*" -and $_.Architecture -eq "X64" }).Version

if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageName      = $env:ChocolateyPackageName
$toolsDir         = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.192.4/standard-notes-3.192.4-win.exe'

Install-ChocolateyZipPackage $packageName $url64bit $toolsDir
