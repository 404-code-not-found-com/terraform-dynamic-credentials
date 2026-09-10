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
  description = "Display name for the app registration. Also prefixes the federated credential names."
}

variable "organization" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise organization name."
}

variable "project" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise project name the workspace belongs to."
}

variable "scope" {
  type        = string
  description = "Azure resource ID the role is assigned at, e.g. a resource group ID."
}

variable "workspace" {
  type        = string
  description = "Workspace name allowed to authenticate."
}

###############################################################################
# Optional Variables (has a default value)
###############################################################################
variable "role_definition_name" {
  type        = string
  description = "Built-in or custom role granted to the service principal at scope."
  default     = "Contributor"
}
