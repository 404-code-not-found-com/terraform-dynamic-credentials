###############################################################################
# variables.tf
#
# Contains all variable blocks in alphabetical order
#
# Two groups Required (no default values)
# Optional (has a default value)
###############################################################################

###############################################################################
# Required Variables (no default values)
###############################################################################
variable "gcp_project_id" {
  type        = string
  description = "Google Cloud project the bucket is created in."
}

variable "name" {
  type        = string
  description = "Prefix for the resources this workload creates."
}

variable "resource_group_name" {
  type        = string
  description = "Existing resource group the workspace has Contributor on."
}

###############################################################################
# Optional Variables (has a default value)
###############################################################################
variable "gcp_region" {
  type        = string
  description = "Google Cloud region for the bucket."
  default     = "us-central1"
}
