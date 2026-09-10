###############################################################################
# outputs.tf
#
# Module outputs in alphabetical order
###############################################################################

output "client_id" {
  description = "Client ID of the app registration the workspace authenticates as."
  value       = azuread_application.this.client_id
}

output "workspace_env_vars" {
  description = "Environment variables to set on the workspace to enable Azure dynamic credentials."
  value = {
    ARM_TENANT_ID           = data.azuread_client_config.current.tenant_id
    TFC_AZURE_PROVIDER_AUTH = "true"
    TFC_AZURE_RUN_CLIENT_ID = azuread_application.this.client_id
  }
}
