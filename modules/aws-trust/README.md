# aws-trust

Lets one HCP Terraform or Terraform Enterprise workspace assume an IAM role with
a workload identity token. Creates the IAM OIDC provider for the platform's
hostname (optional, one per account) and a role whose trust policy matches the
workspace's `sub` claim for both run phases.

Written from the HashiCorp documentation and validated, but not applied from
this repository.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.15 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.64 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.4 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 6.64 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | ~> 4.4 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_iam_openid_connect_provider.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [tls_certificate.issuer](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Create the IAM OIDC provider for hostname. Set to false when it already exists in the account. | `bool` | `true` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the HCP Terraform or Terraform Enterprise instance that issues the workload identity token, without a scheme (e.g. app.terraform.io). | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the IAM role the workspace assumes. | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | HCP Terraform or Terraform Enterprise organization name. | `string` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | IAM policy ARNs attached to the role. | `list(string)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | HCP Terraform or Terraform Enterprise project name the workspace belongs to. | `string` | n/a | yes |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | Workspace name allowed to authenticate. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the IAM role the workspace assumes. |
| <a name="output_workspace_env_vars"></a> [workspace\_env\_vars](#output\_workspace\_env\_vars) | Environment variables to set on the workspace to enable AWS dynamic credentials. |
<!-- END_TF_DOCS -->
