###############################################################################
# data.tf
#
# Contains any data sources
###############################################################################

# Reads during plan, so these prove the plan-phase credentials work.
data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "google_project" "this" {}
