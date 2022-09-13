variable "agent_pool_name" {
  description = "name of agent pool to use"
}

variable "aws_region" {
  description = "region to deploy resources in"
  default     = "us-west-2"
}

variable "hostname" {
  default = "app.terraform.io"
}

variable "oauth_token" {}

variable "org" {}

variable "owner" {
  description = "owner to pass to owner tag"
}

variable "ttl" {
  description = "Hours until instances are reaped by N.E.P.T.R"
  default     = "1"
}

variable "use_case_name" {}

variable "vcs_identifier" {}

variable "TFC_WORKSPACE_NAME" {
  type    = string
  default = "" # An error occurs when you are running TF backend other than Terraform Cloud
}

locals {
  common_tags = {
    owner     = var.owner
    se-region = "AMER - West E2 - R2"
    purpose   = "Producer / Consumer demo"
    ttl       = var.ttl #hours
    terraform = "true"  # true/false
  }

  # If your backend is not Terraform Cloud, the value is ${terraform.workspace} 
  # otherwise the value retrieved is that of the TFC_WORKSPACE_NAME with trimprefix
  my_workspace_env = var.TFC_WORKSPACE_NAME != "" ? trimprefix("${var.TFC_WORKSPACE_NAME}", "my-workspace-") : "${terraform.workspace}"
}

# in development
variable "enable_azure" {
  description = "Provision Azure"
  default     = false
}

variable "enable_gcp" {
  description = "Provision GCP"
  default     = false
}
