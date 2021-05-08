# Using this script we will fetch storage key which is required in terraform file to authenticate backend storage account

$key=(Get-AzureRmStorageAccountKey -ResourceGroupName $(terraformstoragerg) -AccountName $(terraformstorageaccount)).Value[0]

Write-Host "##vso[task.setvariable variable=storagekey]$key"