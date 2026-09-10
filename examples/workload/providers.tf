###############################################################################
# providers.tf
#
# Contains all required_providers terraform blocks and stanzas.
# Contains provider configuration.
###############################################################################

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 8.2"
    }
  }
}

# No credentials anywhere. The run injects a workload identity token and the
# TFC_AZURE_* / TFC_GCP_* workspace variables tell each provider how to trade it
# for short-lived cloud credentials. Subscription and tenant come from
# ARM_SUBSCRIPTION_ID and ARM_TENANT_ID on the workspace.
provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
