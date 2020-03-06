#!/bin/bash

export SAS_CLI_DEFAULT_CAS_SERVER="cas-shared-default"
export SAS_CLI_PROFILE="lab13-viya35"

sas-admin profile set-endpoint "http://lab13-viyaweb.lab.local" 
sas-admin profile toggle-color off 
sas-admin profile set-output fulljson 

sas-admin auth login --user $1 --password $2