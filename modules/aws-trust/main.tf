###############################################################################
# main.tf
#
# Contains resources
###############################################################################

# One OIDC provider per issuer per AWS account. If another configuration
# already created it for this hostname, set create_oidc_provider = false.
resource "aws_iam_openid_connect_provider" "this" {
  count = var.create_oidc_provider ? 1 : 0

  url             = "https://${var.hostname}"
  client_id_list  = ["aws.workload.identity"]
  thumbprint_list = [data.tls_certificate.issuer.certificates[0].sha1_fingerprint]
}

resource "aws_iam_role" "this" {
  name = var.name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Federated = local.oidc_provider_arn }
      Action    = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "${var.hostname}:aud" = "aws.workload.identity"
        }
        # StringLike, not StringEquals: the trailing * is a wildcard only under
        # StringLike. Under StringEquals it is a literal asterisk and never matches.
        StringLike = {
          "${var.hostname}:sub" = "organization:${var.organization}:project:${var.project}:workspace:${var.workspace}:run_phase:*"
        }
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(var.policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.key
}
