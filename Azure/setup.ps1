############################################################

    #ENSURE YOU HAVE AUTHENTICATED TO AZURE WITH AZ LOGIN

############################################################

$rgName = "testPackerGroup"
$location = "UK South"
New-AzResourceGroup -Name $rgName -Location $location

#create service principal to produce credentials required by Packer
#az ad sp create-for-rbac --query "{ client_id: appId, client_secret: password, tenant_id: tenant }"

#Get subscription ID
#az account show --query "{ subscription_id: id }"

#Write-Host "Add the client_id, client secret, tenant id and subscription id to the variables file within this directory"

$sp = New-AzADServicePrincipal -DisplayName "PackerSP$(Get-Random)"
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($sp.Secret)
$plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

Get-AzSubscription

az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/d9247858-c91d-4cc6-92de-cbdcb3975ffd"