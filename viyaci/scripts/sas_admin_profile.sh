#!/bin/bash

export cas_server="cas-shared-default"

sas-admin profile set-endpoint "http://lab10-viyaweb.lab.local" 
sas-admin profile toggle-color off 
sas-admin profile set-output fulljson 

echo "Arguments:" "$@"
echo "Arg 0: $0"
echo "Arg 1: $1"

#sas-admin auth login --user siro --password Orion123
sas-admin auth login --user $1 --password $2