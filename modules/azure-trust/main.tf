###############################################################################
# main.tf
#
# Contains resources
###############################################################################

resource "azuread_application" "this" {
  display_name = var.name
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
}

resource "azurerm_role_assignment" "this" {
  principal_id         = azuread_service_principal.this.object_id
  role_definition_name = var.role_definition_name
  scope                = var.scope
}

# The federated credential subject is an exact string match - no wildcards - so
# a workspace needs one credential per run phase.
resource "azuread_application_federated_identity_credential" "this" {
  for_each = toset(["plan", "apply"])

  application_id = azuread_application.this.id
  audiences      = ["api://AzureADTokenExchange"]
  display_name   = "${var.name}-${each.key}"
  issuer         = "https://${var.hostname}"
  subject        = "organization:${var.organization}:project:${var.project}:workspace:${var.workspace}:run_phase:${each.key}"
}
