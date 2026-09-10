###############################################################################
# outputs.tf
#
# Module outputs in alphabetical order
###############################################################################

output "service_account_email" {
  description = "Email of the service account the workspace impersonates."
  value       = google_service_account.this.email
}

output "workspace_env_vars" {
  description = "Environment variables to set on the workspace to enable Google Cloud dynamic credentials."
  value = {
    TFC_GCP_PROVIDER_AUTH             = "true"
    TFC_GCP_RUN_SERVICE_ACCOUNT_EMAIL = google_service_account.this.email
    TFC_GCP_WORKLOAD_PROVIDER_NAME    = google_iam_workload_identity_pool_provider.this.name
  }
}
