terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
  token      = var.aws_session_token
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "AssumeRoleInstance"
  }
}

output "instance_id" {
  value = aws_instance.example.id
}
