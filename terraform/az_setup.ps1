# this will create Azure resource group
az group create --location westus --name $(terraformstoragerg)

az storage account create --name $(terraformstorageaccount) --resource-group $(terraformstoragerg) --location westus --sku Standard_LRS

az storage container create --name terraform --account-name $(terraformstorageaccount)

az storage account keys list -g $(terraformstoragerg) -n $(terraformstorageaccount)