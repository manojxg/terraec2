variable "region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0c02fb55956c7d316"
}

variable "ROLE_ARN" {
  description = "IAM role ARN to assume"
}
