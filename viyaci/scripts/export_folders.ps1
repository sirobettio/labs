## ====================================
## LOAD PROFILE CONFIGURATIONS
## ====================================
$script = $PSScriptRoot+"\sas_admin_profile.ps1"
. $script

& $sasadm profile set-endpoint $profile_endpoint
& $sasadm profile toggle-color $profile_color
& $sasadm profile set-output $profile_output

& $sasadm auth login --user siro --password Orion123

## ====================================
## LIST HERE THE VIYA FOLDERS TO EXPORT
## ====================================
$folders_folder="C:\dev\prj\labs\viyaci\folders"
$folders_filename = $folders_folder+"\folder_list.txt"
$folders = Get-Content -Path $folders_filename
#$folders = @("HR","SALES")

Write-Output "------------------------------------------------------------------------------------"
foreach($folder_name in $folders) {
    
    Write-Output "Get URI of forder $folder_name"
    $folder_metadata = & $sasadm folders list --name $folder_name
    $folder_metadata_json = $folder_metadata | ConvertFrom-Json
    $folder_id = "/folders/folders/"+$folder_metadata_json.items.id
    Write-Output "URI = $folder_id"
    #
    Write-Output "Create export package for forder $folder_name"
    #$export_log = & $sasadm transfer --profile $profile export --resource-uri $folder_id --name "Export $folder_name folder"
    $export_name = "Export "+$folder_name +" folder"
    $export_msg = & $sasadm transfer export --resource-uri $folder_id --name $export_name
    $export_msg_id_line = $export_msg | findstr ID
    if ($export_msg_id_line -match 'The package with the ID (?<PKGID>.+) was created.') {$export_pkgid = $Matches.PKGID}
    Write-Output "Package id = $export_pkgid"
    #
    $package_filename= $folders_folder+"\folder_export_"+$folder_name+".json"
    Write-Output "Download package $export_pkgid to folder $package_filename"
    & $sasadm transfer download --id $export_pkgid --file $package_filename
    Write-Output "------------------------------------------------------------------------------------"
}
