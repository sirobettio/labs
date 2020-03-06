#!/bin/sh 

mydir=$(dirname "$(readlink -f "$0")")

## ====================================
## LIST HERE THE VIYA FOLDERS TO EXPORT
## ====================================
folders_folder="$mydir/../folders"
folders_filename="$folders_folder/folder_list.txt"

echo "------------------------------------------------------------------------------------"
while IFS= read -r folder_name || [[ -n $folder_name ]] 
do 
    package_filename="$folders_folder/folder_export_$folder_name.json"
		mapping_filename="$folders_folder/folder_mapping_$folder_name.json"
    
		echo "Get URI of forder $folder_name"
		folder_id=`sas-admin --output text folders list --name $folder_name | awk '{if(NR>1)print($1)}'`
    if [ -z "$folder_id" ]; then
		 	echo "[ERROR] Folder $folder_name NOT FOUND."
    else
    	folder_uri="/folders/folders/$folder_id"
			echo "Create export package for forder $folder_uri"
			sas-admin transfer export --resource-uri $folder_uri --name "Export $folder_name folder" > tmp_${folder_name}_pkg_msg.txt 
			export_pkgid=`awk '/The package with the ID/ {print($6)}' tmp_${folder_name}_pkg_msg.txt`
			rm -f tmp_${folder_name}_pkg_msg.txt
			echo "Package id = $export_pkgid"
			
			if [ -z "$export_pkgid" ]; then
				echo "[ERROR] Package creation FAILED."
			else
				echo "Download package $export_pkgid to folder $package_filename"
				sas-admin transfer download --id $export_pkgid --file $package_filename
				
				echo "Create mapping file $mapping_filename"
				sas-admin transfer get-mapping --id $export_pkgid -m $mapping_filename
			fi
		fi
		echo "------------------------------------------------------------------------------------"
done < "$folders_filename"
