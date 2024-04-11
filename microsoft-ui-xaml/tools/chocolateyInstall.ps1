$ErrorActionPreference = 'Stop'

$version = '2.8'

$installedVersion = (Get-AppxPackage | Where-Object { $_.Name -like "*Xaml*" -and $_.Architecture -eq "X64" }).Version

if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageName      = $env:ChocolateyPackageName
$url64bit         = 'https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.4/Microsoft.UI.Xaml.2.8.x64.appx'
$filename         = Get-WebFileName -Url $url64bit -DefaultName "$packageName.appx"

Get-WebFile -Url $url64bit -FileName "$tempPath\$filename"
Add-ProvisionedAppPackage -Online -SkipLicense -PackagePath "$tempPath\$filename"
