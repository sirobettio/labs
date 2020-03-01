$prj_home="C:\dev\prj\labs\viyaci\01-dev"
$cas_server="cas-shared-default"

$sasadm="C:\dev\bin\sas-admin\sas-admin.exe"
& $sasadm profile set-endpoint "http://lab10-viyaweb.lab.local"
& $sasadm profile toggle-color off
& $sasadm profile set-output json
& $sasadm auth login --user siro --password Orion123

#& $sasadm inventory scan services --customer-id "nordiclab" --deployment-label "lab10" --output-location $prj_home\output
& $sasadm inventory scan filesystem --customer-id "nordiclab" --deployment-label "lab10" --output-location $prj_home\output