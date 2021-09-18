﻿$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '3.8.21'

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/desktop/releases/download/v3.8.21/standard-notes-3.8.21-win.exe'
   checksum64       = 'e3b2aa6f1f181469a79f4681ec6db74bca84f8d85699cd5199a00a8dd22b4c59'
   checksumType64   = 'sha256'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
