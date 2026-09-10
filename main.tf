###############################################################################
# main.tf
#
# Contains resources
###############################################################################

#------------------------------------------------------------------------------
# Workspace
#------------------------------------------------------------------------------

resource "tfe_project" "this" {
  organization = var.organization
  name         = var.project
}

resource "tfe_workspace" "this" {
  organization = var.organization
  project_id   = tfe_project.this.id
  name         = var.workspace
}

resource "tfe_workspace_settings" "this" {
  workspace_id   = tfe_workspace.this.id
  execution_mode = "remote"
}

resource "tfe_variable" "env" {
  for_each = local.workspace_env_vars

  workspace_id = tfe_workspace.this.id
  category     = "env"
  key          = each.key
  value        = each.value
}

resource "tfe_variable" "terraform" {
  for_each = local.workspace_terraform_vars

  workspace_id = tfe_workspace.this.id
  category     = "terraform"
  key          = each.key
  value        = each.value
}

#------------------------------------------------------------------------------
# Azure
#------------------------------------------------------------------------------

# The workspace gets Contributor on this resource group and nothing else.
resource "azurerm_resource_group" "this" {
  name     = "${var.name}-rg"
  location = var.azure_location
}

module "azure_trust" {
  source = "./modules/azure-trust"

  hostname     = var.hostname
  name         = var.name
  organization = var.organization
  project      = var.project
  workspace    = var.workspace
  scope        = azurerm_resource_group.this.id
}

#------------------------------------------------------------------------------
# Google Cloud
#------------------------------------------------------------------------------

resource "google_project_service" "this" {
  for_each = toset([
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ])

  service = each.key

  # Other things in the project may depend on these APIs.
  disable_on_destroy = false
}

module "gcp_trust" {
  source = "./modules/gcp-trust"

  hostname           = var.hostname
  organization       = var.organization
  project            = var.project
  workspace          = var.workspace
  project_id         = var.gcp_project_id
  pool_id            = "${var.name}-pool"
  pool_provider_id   = "${var.name}-provider"
  service_account_id = "${var.name}-sa"
  project_roles      = ["roles/storage.admin"]

  depends_on = [google_project_service.this]
}
