# AU Packages Template: https://github.com/majkinetor/au-packages-template
# Copy this file to update_vars.ps1 and set the variables there. Do not include it in the repository.

$Env:mail_user        = ''
$Env:mail_pass        = ''
$Env:mail_server      = ''
$Env:mail_port        = ''
$Env:mail_enablessl   = ''

$Env:api_key          = ''          #Chocolatey api key
$Env:gist_id          = ''          #Specify your gist id or leave empty for anonymous gist
$Env:gist_id_test     = ''          #Specify your gist id for test runs or leave empty for anonymous gist
$Env:git_id           = ''          #Specify your git id or leave empty for anonymous git
$Env:github_user_repo = ''          #{github_user}/{repo}
$Env:github_api_key   = ''          #Github personal access token
$Env:au_Push          = 'false'     #Push to chocolatey