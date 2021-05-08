# this will create Azure resource group
az group create --location westeu --name $(terraformstoragerg)

az storage account create --name $(terraformstorageaccount) --resource-group $(terraformstoragerg) --location westeu --sku Standard_LRS

az storage container create --name terraform --account-name $(terraformstorageaccount)

az storage account keys list -g $(terraformstoragerg) -n $(terraformstorageaccount)