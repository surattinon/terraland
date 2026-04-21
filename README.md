# TerraLand
TerraLand | A project for learning Azure Landing Zone with Terraform

### Terraform state Azure Blob bootstrap
1. Create Blob Storage for tfstate file
```bash
cd bootstrap/
terraform init
terraform plan
terraform apply
```
2. Copy storage account name from output and paste in `environment/sandbox/providers.tf`
```hcl
  backend "azurerm" {
    # ............
    storage_account_name = "<generated blob storage name>" 
    # ............
  }
```

### Secret ENV Variables Setup (for github action)
1. Exec `az accout show` in terminal to get `subscription_id` and `tenent_id`

2. Use this command bellow to create a new service principle with `Contributor` Role.
    ```bash
    az ad sp create-for-rbac --name "sp-<yourprefername>-sandbox" --role="Contributor" --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>"
    ```

3. Copy JSON values from output and look for `appId` and `password`

4. Setup Github Secret with `subscription_id` `tenent_id` `appId` and `password` (will setup ENV variable name later....)