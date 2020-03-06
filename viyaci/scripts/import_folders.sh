#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")

## ====================================
## LIST HERE THE VIYA FOLDERS TO IMPORT
## ====================================
folders_folder="$mydir/../folders"
folders_filename="$folders_folder/folder_list.txt"

echo "------------------------------------------------------------------------------------"
while IFS= read -r folder_name || [[ -n $folder_name ]] 
do 
		package_filename="$folders_folder/folder_export_$folder_name.json"
		mapping_filename="$folders_folder/folder_mapping_$folder_name.json"
		
    if [ ! -f $package_filename ]; then
			 echo "[ERROR] File $package_filename NOT FOUND."
		elif [ ! -f $mapping_filename ]; then
			 echo "[ERROR] File $mapping_filename NOT FOUND."
		else
		  echo "Upload package $package_filename"
			sas-admin transfer upload --file $package_filename > tmp_pkg_${folder_name}.txt 
			package_id=`jq -r .'id' tmp_pkg_${folder_name}.txt`
			echo "Package id = $package_id"
			rm -f tmp_pkg_${folder_name}.txt
			
			if [ -z "$package_id" ]; then
				 echo "[ERROR] Upload package id NOT FOUND."
			else
				echo "Import package $package_id to folder $package_filename"
				sas-admin transfer import --id $package_id --mapping $mapping_filename
			fi
    fi
    echo "------------------------------------------------------------------------------------"
done < "$folders_filename"



