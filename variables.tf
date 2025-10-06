variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  default = "ami-0bc691261a82b32bc"
}

variable "ROLE_ARN" {
  description = "IAM role ARN to assume"
}
