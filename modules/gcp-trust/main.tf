###############################################################################
# main.tf
#
# Contains resources
###############################################################################

resource "google_iam_workload_identity_pool" "this" {
  project                   = var.project_id
  workload_identity_pool_id = var.pool_id
}

resource "google_iam_workload_identity_pool_provider" "this" {
  project                            = var.project_id
  workload_identity_pool_id          = google_iam_workload_identity_pool.this.workload_identity_pool_id
  workload_identity_pool_provider_id = var.pool_provider_id

  attribute_mapping = {
    "google.subject"                        = "assertion.sub"
    "attribute.terraform_organization_name" = "assertion.terraform_organization_name"
    "attribute.terraform_project_name"      = "assertion.terraform_project_name"
    "attribute.terraform_workspace_name"    = "assertion.terraform_workspace_name"
    "attribute.terraform_run_phase"         = "assertion.terraform_run_phase"
  }

  # Without a condition, any organization on the issuer can mint tokens this
  # provider accepts. Pin it to the one workspace, both run phases.
  attribute_condition = "assertion.sub.startsWith(\"organization:${var.organization}:project:${var.project}:workspace:${var.workspace}:\")"

  oidc {
    issuer_uri = "https://${var.hostname}"
  }
}

resource "google_service_account" "this" {
  project    = var.project_id
  account_id = var.service_account_id
}

resource "google_service_account_iam_member" "workload_identity_user" {
  service_account_id = google_service_account.this.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.this.name}/*"
}

resource "google_project_iam_member" "this" {
  for_each = toset(var.project_roles)

  project = var.project_id
  role    = each.key
  member  = google_service_account.this.member
}
