$ErrorActionPreference = 'Stop'

$version = '3.193.10'

$installedVersion = Get-ItemPropertyValue -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f' -Name 'DisplayVersion' -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageArgs = @{
   packageName      = $env:ChocolateyPackageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.193.10/standard-notes-3.193.10-win.exe'
   checksum64       = 'e98653ccd3f0974f9899f1cec56e5f2d1506de2a398c60915a227e4e49f9272b'
   checksumType64   = 'sha265'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
