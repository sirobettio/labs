#!/bin/bash

mydir=$(dirname "$(readlink -f "$0")")
source $mydir/sas_admin.settings

sas-admin profile set-endpoint "http://lab13-viya35.lab.local" 
sas-admin profile toggle-color off 
sas-admin profile set-output fulljson 

sas-admin auth login --user $1 --password $2