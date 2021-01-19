#
$tmp = New-TemporaryFile
$_ip = (Get-CimInstance win32_networkadapterconfiguration -filter "ipenabled = 'True'").ipaddress
$_fqdn = (Resolve-DnsName -Type ALL -name "$_ip").NameHost
$_dnsname = $_fqdn.Split('.')[0]
$_domainname = $_fqdn.Substring($_fqdn.IndexOf(".")+1)
#
Push-Location -Path \opt\filer\os\win\apps\chocolatey-packages
git pull
$_body = "`r`n*** Available Chocolatey updates`r`n"
choco outdated -r -s "https://chocolatey.org/api/v2/;\opt\filer\os\win\apps\chocolatey-packages\automatic" *> $tmp.FullName
$_body += Get-Content -Raw $tmp.FullName
$_body += "`r`n*** Available Windows updates`r`n"
Get-WindowsUpdate *> $tmp.FullName
$_body += Get-Content -Raw $tmp.FullName
Remove-Item $tmp.FullName -Force
Pop-Location
$paramsSendMailmessage = @{
  SmtpServer = "filer"
  From       = "taskscheduler@$_domainname"
  To         = "alim@forwardcomputers.com"
  Subject    = "From $_dnsname"
  Body       = "$_body"
}
Send-MailMessage @paramsSendMailmessage
