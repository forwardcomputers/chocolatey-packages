$ErrorActionPreference = 'Stop'

$version = '3.181.29'

$installedVersion = Get-ItemPropertyValue -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f' -Name 'DisplayVersion' -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host 'Standard Notes $version is already installed.'
    return
}

$packageArgs = @{
   packageName      = $env:ChocolateyPackageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.181.29/standard-notes-3.181.29-win.exe'
   checksum64       = 'd076a8b9d4eed7ee7dbc6ba2261eff9611b2603f5a5cd34eb3ed5262400a5c00'
   checksumType64   = 'sha265'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
