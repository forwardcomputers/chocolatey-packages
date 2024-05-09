
$content = Get-Content Update-AUPackages.md

$timeUCT = ($content | Select-String -Pattern '^\**UTC\**: (.*?) \[').Matches.Groups[1].Value + "Z"
$timeEST = [TimeZoneInfo]::ConvertTimeBySystemTimeZoneId((Get-Date -Date $timeUCT),'Eastern Standard Time').ToString('d--M--yyyy_hh:mm:ss_tt')

$anchors = $content |
Select-String -Pattern '(^\s*\|<img src(.*?)\/>\|)(\[(.*?)\].*?\[(.*?)\].*?\[(.*?)\])' |
ForEach-Object {
    New-Object -TypeName PSObject -Property @{
        Name = $_.Matches.Groups[4].Value
        Version = $_.Matches.Groups[6].Value
    }
}

$linesToWrite = @"
# Chocolatey files
#### Chocolatey files for various Windows applications.
---
| Repository | Status | GitHub | Docker | Tag | Size | Layers |
| --- | --- | :---: | :---: | :--- | :---: | :---: |
| [![](https://img.shields.io/badge/chocolatey-packages-grey)](https://github.com/forwardcomputers/chocolatey-packages) | [![](https://img.shields.io/github/actions/workflow/status/forwardcomputers/chocolatey-packages/main.yml?label)](https://github.com/forwardcomputers/chocolatey-packages/actions) | [![](https://img.shields.io/badge/github--grey?label=&logo=github&logoColor=white)](https://github.com/forwardcomputers/chocolatey-packages) | |
"@
Set-Content -Encoding ASCII -Force -Path README.md -Value $linesToWrite

ForEach($anchor in $anchors) {
    $newName=$($anchor.Name).Normalize("FormD") -replace '-', '_'
    $linesToWrite = "| [![](https://img.shields.io/badge/$newName-grey)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/$($anchor.Name)) | ![](https://img.shields.io/badge/$($timeEST)-blue) | [![](https://img.shields.io/badge/github--grey?label=&logo=github&logoColor=white)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/$($anchor.Name)) | | [![](https://img.shields.io/badge/v$($anchor.Version)-blue)](https://github.com/forwardcomputers/chocolatey-packages/tree/main/$($anchor.Name))"
    Add-Content -Encoding ASCII -Force -Path README.md -Value $linesToWrite
}
