# azure-trust

Lets one HCP Terraform or Terraform Enterprise workspace authenticate to Azure
with a workload identity token. Creates an app registration, its service
principal, a role assignment at `scope`, and two federated credentials, one per
run phase, because Entra ID matches the subject exactly.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.15 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.9 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 5.4 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 3.9 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 5.4 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [azuread_application.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the HCP Terraform or Terraform Enterprise instance that issues the workload identity token, without a scheme (e.g. app.terraform.io). | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Display name for the app registration. Also prefixes the federated credential names. | `string` | n/a | yes |
| <a name="input_organization"></a> [organization](#input\_organization) | HCP Terraform or Terraform Enterprise organization name. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | HCP Terraform or Terraform Enterprise project name the workspace belongs to. | `string` | n/a | yes |
| <a name="input_role_definition_name"></a> [role\_definition\_name](#input\_role\_definition\_name) | Built-in or custom role granted to the service principal at scope. | `string` | `"Contributor"` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | Azure resource ID the role is assigned at, e.g. a resource group ID. | `string` | n/a | yes |
| <a name="input_workspace"></a> [workspace](#input\_workspace) | Workspace name allowed to authenticate. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_client_id"></a> [client\_id](#output\_client\_id) | Client ID of the app registration the workspace authenticates as. |
| <a name="output_workspace_env_vars"></a> [workspace\_env\_vars](#output\_workspace\_env\_vars) | Environment variables to set on the workspace to enable Azure dynamic credentials. |
<!-- END_TF_DOCS -->
