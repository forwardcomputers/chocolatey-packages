$ErrorActionPreference = 'Stop'

$version = '3.193.2'

$installedVersion = Get-ItemPropertyValue -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f' -Name 'DisplayVersion' -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageArgs = @{
   packageName      = $env:ChocolateyPackageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.193.2/standard-notes-3.193.2-win.exe'
   checksum64       = '3abc0787d6d1d5c6d98fadcd9efafc1eb2b25678ab46378f5a0047f9827523c3'
   checksumType64   = 'sha265'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
