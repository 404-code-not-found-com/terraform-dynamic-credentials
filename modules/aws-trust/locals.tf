###############################################################################
# locals.tf
#
# Contains any local variables
###############################################################################

locals {
  oidc_provider_arn = var.create_oidc_provider ? aws_iam_openid_connect_provider.this[0].arn : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${var.hostname}"
}
