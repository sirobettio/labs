#!/bin/bash

export cas_server="cas-shared-default"

sas-admin profile set-endpoint "http://lab10-viyaweb.lab.local" 
sas-admin profile toggle-color off 
sas-admin profile set-output fulljson 

sas-admin auth login --user siro --password Orion123
