data "tfe_outputs" "doormat_role" {
  organization = var.org
  workspace    = "doormat-aws-infra"
}

provider "doormat" {}

data "doormat_aws_credentials" "creds" {
  provider = doormat

  role_arn = data.tfe_outputs.doormat_role.values.terraform_role
}
