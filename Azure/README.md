# Azure Packer Examples

The following is a summary of the supporting [Microsoft Documentation](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/build-image-with-packer)

---

## Prerequisite

- Ensure a resource group exists for the build:

```shell
$rgName = "myPackerGroup"
$location = "East US"
New-AzResourceGroup -Name $rgName -Location $location
```

- Create a Service Principal with a unique `DisplayName`

```shell
$sp = New-AzADServicePrincipal -DisplayName "PackerPrincipal" -role Contributor -scope /subscriptions/yyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyy
$plainPassword = (New-AzADSpCredential -ObjectId $sp.Id).SecretText
```

- Return the password and application ID, storing them securely:

```shell
$plainPassword
$sp.AppId
```

- Get the subscription name and tenant ID:

```shell
$subName = "mySubscriptionName"
$sub = Get-AzSubscription -SubscriptionName $subName
```

- Packer commmands can then be ran as normal.
 