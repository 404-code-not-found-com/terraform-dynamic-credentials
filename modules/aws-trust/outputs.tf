###############################################################################
# outputs.tf
#
# Module outputs in alphabetical order
###############################################################################

output "role_arn" {
  description = "ARN of the IAM role the workspace assumes."
  value       = aws_iam_role.this.arn
}

output "workspace_env_vars" {
  description = "Environment variables to set on the workspace to enable AWS dynamic credentials."
  value = {
    TFC_AWS_PROVIDER_AUTH = "true"
    TFC_AWS_RUN_ROLE_ARN  = aws_iam_role.this.arn
  }
}
