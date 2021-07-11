############################################################

    #ENSURE YOU HAVE AUTHENTICATED TO AZURE WITH AZ LOGIN

############################################################

#create service principal to produce credentials required by Packer
az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

#Get subscription ID
az account show --query "{ subscription_id: id }"

Write-Host "Add the client_id, client secret, tenant id and subscription id to the variables file within this directory"