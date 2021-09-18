$ErrorActionPreference = 'Stop'

$packageName = $env:ChocolateyPackageName
$version = '5.0.49'

$installedVersion = Get-ItemPropertyValue -path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\774f2290-3906-58eb-baae-35b0dc01c31f" -Name "DisplayVersion" -ErrorAction SilentlyContinue
if ( $version -eq $installedVersion ) {
    Write-Host "Standard Notes $version is already installed."
    return
}

$packageArgs = @{
   packageName      = $packageName
   fileType         = 'EXE'
   url64bit         = 'https://www.sharemouse.com/ShareMouseSetup.exe'
   softwareName     = 'ShareMouse'
   silentArgs       = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
   validExitCodes   = @(0)
}

Install-ChocolateyPackage @packageArgs
