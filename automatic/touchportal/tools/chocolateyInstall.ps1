$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '2.2.005'

$installedVersion = Get-ItemPropertyValue -path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Touch Portal_is1" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Touch Portal $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://www.touch-portal.com/downloads/TouchPortal_Setup.exe'
   softwareName     = "Touch Portal*"
   silentArgs       = '/VERYSILENT /NORESTART'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
