$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '3.6.4'

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/desktop/releases/download/v3.6.4/standard-notes-3.6.4-win.exe'
   checksum64       = 'b1c405173993a20fc8075fd2128d0cf847c3c89259c68c1c1c37ae325e55073e'
   checksumType64   = 'sha256'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
