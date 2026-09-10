# gcp-trust

Lets one HCP Terraform or Terraform Enterprise workspace authenticate to Google
Cloud with a workload identity token. Creates a workload identity pool and OIDC
provider, with an attribute condition pinned to the workspace, and a service
account the workspace impersonates.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.15 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 8.2 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | ~> 8.2 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_iam_workload_identity_pool.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.workload_identity_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the HCP Terraform or Terraform Enterprise instance that issues the workload identity token, without a scheme (e.g. app.terraform.io). | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | HCP Terraform or Terraform Enterprise organization name. | `string` | n/a | yes |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Workload identity pool ID. | `string` | n/a | yes |
| <a name="input_pool_provider_id"></a> [pool\_provider\_id](#input\_pool\_provider\_id) | Workload identity pool provider ID. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | HCP Terraform or Terraform Enterprise project name the workspace belongs to. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Google Cloud project ID that holds the pool and service account. | `string` | n/a | yes |
| <a name="input_project_roles"></a> [project\_roles](#input\_project\_roles) | Project-level roles granted to the service account. | `list(string)` | `[]` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Account ID (the part before the @) of the service account the workspace impersonates. | `string` | n/a | yes |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | Workspace name allowed to authenticate. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | Email of the service account the workspace impersonates. |
| <a name="output_workspace_env_vars"></a> [workspace\_env\_vars](#output\_workspace\_env\_vars) | Environment variables to set on the workspace to enable Google Cloud dynamic credentials. |
<!-- END_TF_DOCS -->
