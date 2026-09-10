###############################################################################
# outputs.tf
#
# Module outputs in alphabetical order
###############################################################################

output "bucket_name" {
  description = "Name of the Google Cloud Storage bucket created with dynamic credentials."
  value       = google_storage_bucket.this.name
}

output "network_security_group_id" {
  description = "ID of the Azure network security group created with dynamic credentials."
  value       = azurerm_network_security_group.this.id
}
