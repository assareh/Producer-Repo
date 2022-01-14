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

variable "token" {
  description = "TFE User Token"
}

variable "use_case_name" {}

variable "vcs_identifier" {}