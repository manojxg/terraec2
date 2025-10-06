terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }
}

# Command to run AWS STS assume-role and capture JSON
data "external" "assume_role" {
  program = ["bash", "-c", <<EOT
aws sts assume-role \
  --role-arn "${ROLE_ARN}" \
  --role-session-name "terraform-session" \
  --output json
EOT
  ]
}

# Extract credentials from JSON output
locals {
  access_key    = data.external.assume_role.result["Credentials"]["AccessKeyId"]
  secret_key    = data.external.assume_role.result["Credentials"]["SecretAccessKey"]
  session_token = data.external.assume_role.result["Credentials"]["SessionToken"]
}

# Provider using the assumed role credentials
provider "aws" {
  region                  = var.region
  access_key              = local.access_key
  secret_key              = local.secret_key
  token                   = local.session_token
}

# Example: Create an EC2 instance using assumed role creds
resource "aws_instance" "test" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "AssumedRoleInstance"
  }
}

output "instance_id" {
  value = aws_instance.test.id
}
