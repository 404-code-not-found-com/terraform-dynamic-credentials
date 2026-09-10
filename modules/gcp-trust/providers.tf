###############################################################################
# providers.tf
#
# Contains all required_providers terraform blocks and stanzas.
###############################################################################

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 8.2"
    }
  }
}
