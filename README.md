# Terraform Dynamic Credentials

Short-lived cloud credentials for HCP Terraform and Terraform Enterprise runs,
using workload identity (OIDC) instead of stored access keys. Companion code for
[Stop Minting Static Credentials](https://www.404-code-not-found.com/posts/stop-minting-static-credentials/).

Every run gets a signed JSON Web Token (JWT) from the Terraform platform. The cloud trusts the
platform as an identity provider, checks the token's claims against the
workspace it expects, and hands back credentials that expire with the run.
Nothing long-lived is stored in the workspace.

## Layout

| Path | Runs | What it does |
| --- | --- | --- |
| `.` (root) | Locally, with admin credentials | Builds the trust in Azure and Google Cloud for one workspace, then creates that workspace with the variables that switch dynamic credentials on. |
| `modules/azure-trust` | - | App registration, service principal, role assignment, and one federated credential per run phase. |
| `modules/gcp-trust` | - | Workload identity pool and provider, and a service account the workspace impersonates. |
| `modules/aws-trust` | - | IAM OIDC provider and role. Not called from the root; see [What was verified](#what-was-verified). |
| `examples/workload` | In the workspace, remote execution | Reads during plan and creates during apply in both clouds, with no credentials in the configuration. |

## Usage

The root configuration targets one platform per state. To build against HCP
Terraform and Terraform Enterprise side by side, use a CLI workspace and a
tfvars file for each, with a different `name` so the cloud-side objects don't
collide.

```bash
cp example.tfvars hcp.tfvars   # edit: subscription, project, hostname, org, name
az login
gcloud auth application-default login
export TFE_TOKEN=...           # a token that can create projects and workspaces

terraform init
terraform workspace new hcp
terraform apply -var-file=hcp.tfvars
```

Then run the workload in the workspace it created:

```bash
cd examples/workload
export TF_CLOUD_HOSTNAME=app.terraform.io TF_CLOUD_ORGANIZATION=my-org TF_WORKSPACE=dynamic-credentials-demo
terraform init
terraform apply
```

The root `workload_env` output prints those three values.

## What was verified

- **Azure and Google Cloud**: applied against both HCP Terraform and a
  self-hosted Terraform Enterprise, with a full plan and apply of
  `examples/workload` in each.
- **AWS**: `modules/aws-trust` follows the HashiCorp documentation and passes
  `terraform validate`, but has not been applied from this repository.

## Things that bite

- **Azure needs two federated credentials per workspace.** The subject is an
  exact match, and the token's subject ends in `run_phase:plan` or
  `run_phase:apply`. With only the plan credential, the plan succeeds and the
  apply fails with `AADSTS700213: No matching federated identity record found`.
- **Flexible federated credentials only help on HCP Terraform.** Microsoft's
  preview wildcard matching (`claims['sub'] matches '...:run_phase:*'`) works
  for `https://app.terraform.io`, and is rejected for a Terraform Enterprise
  hostname with `Expression is not supported for applications in this cloud
  'Public' using issuer`.
- **The Google Cloud attribute condition is what scopes the pool.** The service
  account binding admits any identity in the pool, so the condition on the
  provider is the only check that the token came from your workspace. A
  mismatch fails at plan with `The given credential is rejected by the
  attribute condition.`
- **Terraform Enterprise must be reachable by the cloud.** The cloud fetches
  `/.well-known/openid-configuration` and `/.well-known/jwks` from your
  hostname. HashiCorp's documentation also states that Azure and Google Cloud
  dynamic credentials don't work with a custom or self-signed certificate on
  Terraform Enterprise.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| terraform | ~> 1.16 |
| azuread | ~> 3.9 |
| azurerm | ~> 5.4 |
| google | ~> 8.2 |
| tfe | ~> 0.80 |

## Providers

| Name | Version |
| ---- | ------- |
| azurerm | ~> 5.4 |
| google | ~> 8.2 |
| tfe | ~> 0.80 |

## Modules

| Name | Source | Version |
| ---- | ------ | ------- |
| azure\_trust | ./modules/azure-trust | n/a |
| gcp\_trust | ./modules/gcp-trust | n/a |

## Resources

| Name | Type |
| ---- | ---- |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [google_project_service.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [tfe_project.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/project) | resource |
| [tfe_variable.env](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.terraform](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_settings.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| azure\_subscription\_id | Azure subscription that holds the demo resource group. | `string` | n/a | yes |
| gcp\_project\_id | Google Cloud project that holds the workload identity pool and service account. | `string` | n/a | yes |
| hostname | Hostname of the HCP Terraform or Terraform Enterprise instance, without a scheme (e.g. app.terraform.io). | `string` | n/a | yes |
| name | Prefix for every cloud-side object. Must be unique per platform when this configuration is applied against more than one. Lowercase letters, digits and hyphens, 4-20 characters. | `string` | n/a | yes |
| organization | HCP Terraform or Terraform Enterprise organization the demo workspace is created in. | `string` | n/a | yes |
| azure\_location | Azure region for the demo resource group. | `string` | `"centralus"` | no |
| gcp\_region | Google Cloud region for the demo bucket. | `string` | `"us-central1"` | no |
| project | Project the demo workspace is created in. Created by this configuration. | `string` | `"dynamic-credentials-demo"` | no |
| workspace | Name of the demo workspace. Created by this configuration. | `string` | `"dynamic-credentials-demo"` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| workload\_env | Environment variables that point examples/workload at the demo workspace. |
| workspace\_env\_vars | Environment variables set on the demo workspace. |
<!-- END_TF_DOCS -->
