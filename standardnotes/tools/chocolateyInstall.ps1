$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '3.173.4.20230927'

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://github.com/standardnotes/app/releases/download/%40standardnotes/desktop%403.173.4/standard-notes-3.173.4-win.exe'
   checksum64       = '6a381a150fbf2e086f1d8cc9c39dd4bb24e4762eb198ed51a8153beec6856268'
   checksumType64   = 'sha256'
   softwareName     = 'Standard Notes*'
   silentArgs       = '/S'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
