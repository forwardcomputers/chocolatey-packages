
$content = Get-Content Update-AUPackages.md

$timeUCT = ($content | Select-String -Pattern '^\**UTC\**: (.*?) \[').Matches.Groups[1].Value + "Z"
$timeEST = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $timeUCT),'Eastern Standard Time').ToString('d--M--yyyy_hh:mm:ss_tt')

$anchors = $content |
Select-String -Pattern '^\s*\|<img src(.*?)\/>\|\[(.*?)\].*\[(.*?)\]' |
ForEach-Object {
    New-Object -TypeName PSObject -Property @{
        Version = $_.Matches.Groups[3].Value
        Name = $_.Matches.Groups[2].Value
    }
}

$linesToWrite = @"
# Chocolatey files
#### Chocolatey files for various Windows applications.
---
| Repository | Status | GitHub | Docker | Tag | Size | Layers |
| --- | --- | :---: | :---: | :--- | :---: | :---: |
| [![](https://img.shields.io/badge/chocolatey-packages-grey.svg)](https://github.com/forwardcomputers/chocolatey-packages) | [![](img.shields.io/github/actions/workflow/status/forwardcomputers/dockerfiles/build_all?label)](https://github.com/forwardcomputers/dockerfiles/actions) | [![](https://img.shields.io/badge/github--grey.svg?label=&logo=github&logoColor=white)](https://github.com/forwardcomputers/chocolatey-packages) | |
"@
Set-Content -Encoding ASCII -Force -Path README.md -Value $linesToWrite

ForEach($anchor in $anchors) {
    $linesToWrite = "| [![](https://img.shields.io/badge/$($anchor.Name)-grey.svg)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/automatic/$($anchor.Name)) | ![](https://img.shields.io/badge/$($timeEST)-blue.svg) | [![](https://img.shields.io/badge/github--grey.svg?label=&logo=github&logoColor=white)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/automatic/$($anchor.Name)) | | [![](https://img.shields.io/badge/v$($anchor.Version)-blue.svg)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/automatic/$($anchor.Name))"
    Add-Content -Encoding ASCII -Force -Path README.md -Value $linesToWrite
}
