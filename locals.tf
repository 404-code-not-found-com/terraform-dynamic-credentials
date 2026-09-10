###############################################################################
# locals.tf
#
# Contains any local variables
###############################################################################

locals {
  # Everything the workspace needs to authenticate, and nothing secret: client
  # IDs, role ARNs and provider names are identifiers, not credentials.
  workspace_env_vars = merge(
    module.azure_trust.workspace_env_vars,
    module.gcp_trust.workspace_env_vars,
    {
      ARM_SUBSCRIPTION_ID = var.azure_subscription_id
    },
  )

  workspace_terraform_vars = {
    gcp_project_id      = var.gcp_project_id
    gcp_region          = var.gcp_region
    name                = var.name
    resource_group_name = azurerm_resource_group.this.name
  }
}
