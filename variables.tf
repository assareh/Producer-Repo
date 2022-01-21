// variable "aws_access_key" {}

variable "aws_region" {
  description = "region to deploy resources in"
  default     = "us-west-2"
}

// variable "aws_secret_key" {}

variable "creator_workspace" {}

variable "hostname" {
  default = "app.terraform.io"
}

variable "oauth_token" {}

variable "org" {}

variable "owner" {
  description = "owner to pass to owner tag"
}

variable "token" {
  description = "TFE User Token"
}

variable "ttl" {
  description = "Hours until instances are reaped by N.E.P.T.R"
  default     = "1"
}

variable "use_case_name" {}

variable "vcs_identifier" {}

locals {
  common_tags = {
    owner     = var.owner
    se-region = "AMER - West E2 - R2"
    purpose   = "Producer / Consumer demo"
    ttl       = var.ttl #hours
    terraform = "true"  # true/false
  }
}
