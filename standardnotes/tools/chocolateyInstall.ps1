$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version =  3.5.11

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         =  https://github.com/standardnotes/desktop/releases/download/v3.5.11/standard-notes-3.5.11-win.exe
   checksum64       =  f1a1765a92bee26c517f1bf77f5a93cc2e2f9b9431e86dfa124dcfc748057f88
   checksumType64   = 'sha256'
   softwareName     = "Standard Notes*"
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
