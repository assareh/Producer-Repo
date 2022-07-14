terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }

    doormat = {
      source  = "doormat.hashicorp.services/hashicorp-security/doormat"
      version = "~> 0.0.2"
    }
  }
}