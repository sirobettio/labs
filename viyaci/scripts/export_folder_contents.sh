#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")

## ====================================
## Connect with sas-admin
## ====================================
. $mydir/sas_admin_profile.sh

## ====================================
## LIST HERE THE VIYA FOLDERS TO EXPORT
## ====================================
folders_folder="$mydir/../folders"
folders_filename="$folders_folder/folder_list.txt"

echo "------------------------------------------------------------------------------------"

while IFS= read -r folder_name || [[ -n $folder_name ]] 
do 
    echo "Get URI of forder $folder_name"
    folder_id=`sas-admin --output text folders list --name $folder_name | awk '{if(NR>1)print($1)}'`
    folder_uri="/folders/folders/$folder_id"
    echo "URI = $folder_uri"
    
    echo "Create export package for forder $folder_name"
    sas-admin transfer export --resource-uri $folder_uri --name "Export $folder_name folder" > tmp_pkg_msg.txt 
    export_pkgid=`awk '/The package with the ID/ {print($6)}' tmp_pkg_msg.txt`
    rm -f tmp_pkg_msg.txt
    echo "Package id = $export_pkgid"

    package_filename="$folders_folder/folder_export_$folder_name.json"
    echo "Download package $export_pkgid to folder $package_filename"
    sas-admin transfer download --id $export_pkgid --file $package_filename
    echo "------------------------------------------------------------------------------------"
done < "$folders_filename"
