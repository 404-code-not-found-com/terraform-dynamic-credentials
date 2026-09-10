###############################################################################
# outputs.tf
#
# Module outputs in alphabetical order
###############################################################################

output "workload_env" {
  description = "Environment variables that point examples/workload at the demo workspace."
  value = {
    TF_CLOUD_HOSTNAME     = var.hostname
    TF_CLOUD_ORGANIZATION = var.organization
    TF_WORKSPACE          = tfe_workspace.this.name
  }
}

output "workspace_env_vars" {
  description = "Environment variables set on the demo workspace."
  value       = local.workspace_env_vars
}
