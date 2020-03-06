#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")
source $mydir/sas_admin.settings

## ==================================================
## Connect with sas-admin
## ==================================================
export casblis_acl_folder="${mydir}/../caslibs/acl"
export casblis_def_folder="${mydir}/../caslibs/def"

## ---------------------------------------------------------------
## caslib: HRDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --source-file "${casblis_def_folder}/HRDATA-defs.json"
yes y | sas-admin cas caslibs replace-controls --name HRDATA --source-file "${casblis_acl_folder}/acl_HRDATA.json"

## ---------------------------------------------------------------
## caslib: TESTDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --source-file "${casblis_def_folder}/TESTDATA-defs.json"
yes y | sas-admin cas caslibs replace-controls --name TESTDATA --source-file "${casblis_acl_folder}/acl_TESTDATA.json"

## ---------------------------------------------------------------
## caslib: SALESDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --source-file "${casblis_def_folder}/SALESDATA-defs.json"
yes y | sas-admin cas caslibs replace-controls --name SALESDATA --source-file "${casblis_acl_folder}/acl_SALESDATA.json"

## ---------------------------------------------------------------
## caslib: ENCRYPTDATA
## ---------------------------------------------------------------

sas-admin cas caslibs create path --source-file "${casblis_def_folder}/ENCRYPTDATA-defs.json"
yes y | sas-admin cas caslibs replace-controls --name ENCRYPTDATA --source-file "${casblis_acl_folder}/acl_ENCRYPTDATA.json"