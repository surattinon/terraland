# TerraLand
TerraLand | A project for learning Azure Landing Zone with Terraform

## Secret ENV Variables Setup (for github action)
1. Exec ```az accout show``` in terminal to get ```subscription_id``` and ```tenent_id```

2. Use this command bellow to create a contributor.
    ```bash
    az ad sp create-for-rbac --name "sp-<yourprefername>-sandbox" --role="Contributor" --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>"
    ```

3. Copy JSON values from output and look for ```appId``` and ```password```

4. Setup Github Secret for ```subscription_id``` ```tenent_id``` ```appId``` and ```password``` (will setup ENV variable name later....)