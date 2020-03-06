#!/bin/bash

mydir=$(dirname "$(readlink -f "$0")")
#source $mydir/sas_admin.settings

if [ "$#" -ne 2 ]; then
    echo "Usage: sas_admin_login <username> <passwd>"
    exit 1
fi

if [ -z "$SAS_CLI_PROFILE" ]; then
	echo "[ERROR] SAS_CLI_PROFILE must be set."
	sas-admin profile list
	exit 1
fi

if [ -z "$SSL_CERT_FILE" ]; then
	echo "[WARN] SSL_CERT_FILE not set. Set to: $mydir/../ssl/NordicLabs_Bundle.pem"
	export SSL_CERT_FILE="$mydir/../ssl/NordicLabs_Bundle.pem"
fi
                                                                                    
#sas-admin profile set-endpoint "http://lab10-viya35.lab.local" 
#sas-admin profile toggle-color off 
#sas-admin profile set-output fulljson 

sas-admin auth login --user $1 --password $2

sas-admin profile show