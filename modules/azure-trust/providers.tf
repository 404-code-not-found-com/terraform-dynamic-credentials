###############################################################################
# providers.tf
#
# Contains all required_providers terraform blocks and stanzas.
###############################################################################

terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.9"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}
