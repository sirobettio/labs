#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")

## ==================================================
## Connect with sas-admin
## ==================================================
export casblis_acl_folder=$mydir/acl
export casblis_def_folder=$mydir/def

## ---------------------------------------------------------------
## caslib: HRDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --source-file "$casblis_def_folder\HRDATA-defs.json"

yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"

## ---------------------------------------------------------------
## caslib: TESTDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --server $cas_server --source-file "$casblis_def_folder\TESTDATA-defs.json"

yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "$casblis_acl_folder\acl_policy_00_ALL_SASAdministrators.json"
yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "$casblis_acl_folder\acl_policy_01_RW_SASDevelopers.json"
yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "$casblis_acl_folder\acl_policy_99_R_AuthenticatedUsers.json"
