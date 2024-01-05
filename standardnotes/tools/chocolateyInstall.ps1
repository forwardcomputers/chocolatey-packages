$ErrorActionPreference = 'Stop'

$version = '3.183.39'

$installedVersion = Get-ItemPropertyValue -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f' -Name 'DisplayVersion' -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageArgs = @{
   packageName      = $env:ChocolateyPackageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.183.39/standard-notes-3.183.39-win.exe'
   checksum64       = '17e6112cb8e3f584d062dc0e921540722c0e03496e2f674cb12b5ac0c5cfaf1d'
   checksumType64   = 'sha265'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
