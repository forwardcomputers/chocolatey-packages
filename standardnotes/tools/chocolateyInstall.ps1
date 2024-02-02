$ErrorActionPreference = 'Stop'

$version = '3.187.3'

$installedVersion = Get-ItemPropertyValue -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f' -Name 'DisplayVersion' -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageArgs = @{
   packageName      = $env:ChocolateyPackageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.187.3/standard-notes-3.187.3-win.exe'
   checksum64       = 'eb02ba6eed2547203c6f636ca200a0f531c1c37b5d83c1e55fdbeddfd8e506b9'
   checksumType64   = 'sha265'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
