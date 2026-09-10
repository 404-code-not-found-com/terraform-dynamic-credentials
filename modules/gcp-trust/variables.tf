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
variable "hostname" {
  type        = string
  description = "Hostname of the HCP Terraform or Terraform Enterprise instance that issues the workload identity token, without a scheme (e.g. app.terraform.io)."
}

variable "organization" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise organization name."
}

variable "pool_id" {
  type        = string
  description = "Workload identity pool ID."
}

variable "pool_provider_id" {
  type        = string
  description = "Workload identity pool provider ID."
}

variable "project" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise project name the workspace belongs to."
}

variable "project_id" {
  type        = string
  description = "Google Cloud project ID that holds the pool and service account."
}

variable "service_account_id" {
  type        = string
  description = "Account ID (the part before the @) of the service account the workspace impersonates."
}

variable "workspace" {
  type        = string
  description = "Workspace name allowed to authenticate."
}

###############################################################################
# Optional Variables (has a default value)
###############################################################################
variable "project_roles" {
  type        = list(string)
  description = "Project-level roles granted to the service account."
  default     = []
}
