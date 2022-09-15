provider "aws" {
  # access_key = data.doormat_aws_credentials.creds.access_key
  # secret_key = data.doormat_aws_credentials.creds.secret_key
  # token      = data.doormat_aws_credentials.creds.token

  default_tags {
    tags = local.common_tags
  }

  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "development" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "development"
  }
}

resource "aws_subnet" "staging" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "staging"
  }
}

resource "aws_subnet" "production" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "production"
  }
}

data "aws_caller_identity" "current" {
}

output "caller" {
  value = data.aws_caller_identity.current.arn
}
