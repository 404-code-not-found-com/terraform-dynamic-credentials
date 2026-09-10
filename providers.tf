###############################################################################
# providers.tf
#
# Contains all required_providers terraform blocks and stanzas.
# Contains provider configuration.
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
    google = {
      source  = "hashicorp/google"
      version = "~> 8.2"
    }
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.80"
    }
  }
}

# Credentials for every provider come from the environment of whoever runs this
# configuration (az login, gcloud ADC, TFE_TOKEN). This is the one place
# long-lived admin access is still needed: to build the trust.

provider "azuread" {}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

provider "tfe" {
  hostname = var.hostname
}
