resource "azurerm_resource_group_policy_assignment" "vm_sku_policy" {
  name = "finops-allowed-vm-skus"
  resource_group_id = var.resource_group_id

  policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3"

  description = "FinOps Shield: Rnsures only Free Tier VMs can be deploy"
  display_name = "FinOps: Allowed VM Size SKUs"

  parameters = jsonencode({
    "listOfAllowedSKUs": {
        "value": var.allowed_vm_skus
    }
  })
}