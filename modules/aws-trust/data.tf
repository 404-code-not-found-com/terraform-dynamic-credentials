###############################################################################
# data.tf
#
# Contains any data sources
###############################################################################

data "aws_caller_identity" "current" {}

data "tls_certificate" "issuer" {
  url = "https://${var.hostname}"
}
