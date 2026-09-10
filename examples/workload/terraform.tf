###############################################################################
# terraform.tf
#
# Contains a single terraform block which defines your required_version.
###############################################################################

terraform {
  required_version = "~> 1.15"

  # Hostname, organization and workspace come from TF_CLOUD_HOSTNAME,
  # TF_CLOUD_ORGANIZATION and TF_WORKSPACE (see the root workload_env output).
  cloud {}
}
