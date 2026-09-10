###############################################################################
# main.tf
#
# Contains resources
###############################################################################

# Created during apply, so these prove the apply-phase credentials work. Both
# are free to leave running.
resource "azurerm_network_security_group" "this" {
  name                = "${var.name}-nsg"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
}

# A customer-managed key would add a KMS key ring to an empty demo bucket.
#trivy:ignore:GCP-0066
resource "google_storage_bucket" "this" {
  name     = "${var.name}-${data.google_project.this.number}"
  location = upper(var.gcp_region)

  force_destroy               = true
  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
