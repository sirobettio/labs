$casblis_folder="C:\dev\prj\labs\viyaci\caslibs"
$casblis_def_folder = $casblis_folder+"\def"
$casblis_acl_folder = $casblis_folder+"\acl"

$cas_server="cas-shared-default"

$sasadm="C:\dev\bin\sas-admin\sas-admin.exe"

## ===============================================================
## !!! SET THE END POINT
& $sasadm profile set-endpoint "http://lab14-viya35.lab.local"
#& $sasadm profile set-endpoint "http://lab10-viaweb.lab.local"

& $sasadm profile toggle-color off
& $sasadm profile set-output json
& $sasadm auth login --user siro --password Orion123
## ===============================================================

## ---------------------------------------------------------------
## caslib: HRDATA
## ---------------------------------------------------------------

& $sasadm cas caslibs create path --server $cas_server --source-file "$casblis_def_folder\HRDATA-defs.json"

echo Y | & $sasadm cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
echo Y | & $sasadm cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"

## ---------------------------------------------------------------
## caslib: TESTDATA
## ---------------------------------------------------------------

& $sasadm cas caslibs create path --server $cas_server --source-file "$casblis_def_folder\TESTDATA-defs.json"

echo Y | & $sasadm cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
echo Y | & $sasadm cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"
echo Y | & $sasadm cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_99_R_AuthenticatedUsers.json"
