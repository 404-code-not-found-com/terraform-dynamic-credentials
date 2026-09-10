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

variable "name" {
  type        = string
  description = "Name of the IAM role the workspace assumes."
}

variable "organization" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise organization name."
}

variable "project" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise project name the workspace belongs to."
}

variable "workspace" {
  type        = string
  description = "Workspace name allowed to authenticate."
}

###############################################################################
# Optional Variables (has a default value)
###############################################################################
variable "create_oidc_provider" {
  type        = bool
  description = "Create the IAM OIDC provider for hostname. Set to false when it already exists in the account."
  default     = true
}

variable "policy_arns" {
  type        = list(string)
  description = "IAM policy ARNs attached to the role."
  default     = []
}
