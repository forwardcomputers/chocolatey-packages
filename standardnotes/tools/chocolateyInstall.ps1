$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '3.22.11'

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/desktop/releases/download/v3.22.11/standard-notes-3.22.11-win.exe'
   checksum64       = 'fb3d2084a86b122f5cef330f1974ad33790d6fb3207d3262af7f78f0d51fbe3b'
   checksumType64   = 'sha256'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
