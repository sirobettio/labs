#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")

## ==================================================
## Connect with sas-admin
## ==================================================
. $mydir/sas_admin_profile.sh

export casblis_acl_folder = $mydir/acl
export casblis_def_folder = $mydir/def

## ---------------------------------------------------------------
## caslib: HRDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --server $cas_server --source-file "$casblis_def_folder\HRDATA-defs.json"

yes y | sas-admin cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
yes y | sas-admin cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"

## ---------------------------------------------------------------
## caslib: TESTDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --server $cas_server --source-file "$casblis_def_folder\TESTDATA-defs.json"

yes y | sas-admin cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
yes y | sas-admin cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"
yes y | sas-admin cas caslibs replace-controls --server $cas_server --name HRDATA --source-file "$casblis_acl_folder\acl_policy_99_R_AuthenticatedUsers.json"
