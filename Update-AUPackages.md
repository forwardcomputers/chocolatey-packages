# Update-AUPackages
[![1](https://img.shields.io/badge/AU%20packages-1-red.svg)](#ok)
[![2022.10.24](https://img.shields.io/badge/AU-2022.10.24-blue.svg)](https://www.powershellgallery.com/packages/AU)
[![](http://transparent-favicon.info/favicon.ico)](#)[![](http://transparent-favicon.info/favicon.ico)](#)
**UTC**: 2024-03-23 10:11 [![](http://transparent-favicon.info/favicon.ico)](#) [](https://github.com/)

_This file is automatically generated by the [update_all.ps1](https://github.com/majkinetor/au-packages-template/blob/master/update_all.ps1) script using the [AU module](https://github.com/majkinetor/au)._

[Ignored](#ignored) | [History](#update-history) | [Force Test](https://gist.github.com/) | [Releases](https://github.com//tags)

<img src='https://cdn.jsdelivr.net/gh/majkinetor/au@master/AU/Plugins/Report/r_ok.png' width='24'> **Last run was OK**

Finished 1 packages after .1 minutes.  
1 updated, 0 pushed, 0 ignored  
0 errors - 0 update, 0 push.  


## OK


|Icon|Name|Updated|Pushed|RemoteVersion|NuspecVersion|
|---|---|---|---|---|---|
|<img src="https://raw.githubusercontent.com/standardnotes/app/main/packages/desktop/build/icon/Icon-512x512.png" width="32" height="32"/>|[standardnotes](https://chocolatey.org/packages/standardnotes/3.192.4)|[True](#standardnotes) &#x1F538; &#x1F4E5;|False|[3.192.4](https://standardnotes.com)|[3.191.4](https://github.com/USERNAME/REPOSITORY-NAME/tree/master/automatic/standardnotes)|


### standardnotes



```
standardnotes - checking updates using au version 2022.10.24

URL check
  https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.192.4/standard-notes-3.192.4-win.exe
nuspec version: 3.191.4
remote version: 3.192.4
New version is available
Automatic checksum skipped
Updating files
  $Latest data:
    Checksum64                (String)     912529d3d694e91388531ea1bda850dcc58ceba6da72f69198a5b97f370be180
    ChecksumType64            (String)     sha265
    FileType                  (String)     exe
    NuspecVersion             (String)     3.191.4
    PackageName               (String)     standardnotes
    URL64                     (String)     https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.192.4/standard-notes-3.192.4-win.exe
    Version                   (String)     3.192.4
  standardnotes.nuspec
    setting id: standardnotes
    updating version: 3.191.4 -> 3.192.4
  .\tools\chocolateyInstall.ps1
    (?i)(^[$]version\s*=\s*)('.*')      = ${1}'3.192.4'
    (?i)(^\s*checksum64\s*=\s*)('.*')   = ${1}'912529d3d694e91388531ea1bda850dcc58ceba6da72f69198a5b97f370be180'
    (?i)(^\s*checksumType64\s*=\s*)('.*') = ${1}'sha265'
    (?i)(^\s*url64bit\s*=\s*)('.*')     = ${1}'https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.192.4/standard-notes-3.192.4-win.exe'
  .\legal\VERIFICATION.txt
    (?i)(\s*has been obtained from\s*)\<.*\> = ${1}<https://raw.githubusercontent.com/standardnotes/app/main/LICENSE>
    (?i)(^\s*64-Bit software\:).*       = ${1} https://github.com/standardnotes/app/releases/download/@standardnotes/desktop@3.192.4/standard-notes-3.192.4-win.exe
    (?i)(^\s*checksum64\:).*            = ${1} 912529d3d694e91388531ea1bda850dcc58ceba6da72f69198a5b97f370be180
    (?i)(^\s*checksum type\:).*         = ${1} sha265
Running au_AfterUpdate
Attempting to build package from 'standardnotes.nuspec'.
Successfully created package 'D:\a\chocolatey-packages\chocolatey-packages\standardnotes\standardnotes.3.192.4.nupkg'

Package updated
```

