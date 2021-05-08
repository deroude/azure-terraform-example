# this will create Azure resource group
az group create --location westeu --name $Env:terraformstoragerg

az storage account create --name $Env:terraformstorageaccount --resource-group $Env:terraformstoragerg --location westeu --sku Standard_LRS

az storage container create --name terraform --account-name $Env:terraformstorageaccount

az storage account keys list -g $Env:terraformstoragerg -n $Env:terraformstorageaccount