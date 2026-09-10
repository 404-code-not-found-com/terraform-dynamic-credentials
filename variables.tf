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
variable "azure_subscription_id" {
  type        = string
  description = "Azure subscription that holds the demo resource group."
}

variable "gcp_project_id" {
  type        = string
  description = "Google Cloud project that holds the workload identity pool and service account."
}

variable "hostname" {
  type        = string
  description = "Hostname of the HCP Terraform or Terraform Enterprise instance, without a scheme (e.g. app.terraform.io)."
}

variable "name" {
  type        = string
  description = "Prefix for every cloud-side object. Must be unique per platform when this configuration is applied against more than one. Lowercase letters, digits and hyphens, 4-20 characters."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{3,19}$", var.name))
    error_message = "The name must be 4-20 characters of lowercase letters, digits and hyphens, starting with a letter."
  }
}

variable "organization" {
  type        = string
  description = "HCP Terraform or Terraform Enterprise organization the demo workspace is created in."
}

###############################################################################
# Optional Variables (has a default value)
###############################################################################
variable "azure_location" {
  type        = string
  description = "Azure region for the demo resource group."
  default     = "centralus"
}

variable "gcp_region" {
  type        = string
  description = "Google Cloud region for the demo bucket."
  default     = "us-central1"
}

variable "project" {
  type        = string
  description = "Project the demo workspace is created in. Created by this configuration."
  default     = "dynamic-credentials-demo"
}

variable "workspace" {
  type        = string
  description = "Name of the demo workspace. Created by this configuration."
  default     = "dynamic-credentials-demo"
}
