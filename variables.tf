variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  default = "ami-0bc691261a82b32bc" # Amazon Linux 2 AMI
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "Manoj-test" # must exist in AWS
}

variable "aws_profile" {
  default = "AWS-SS-Dev"  # 👈 AWS CLI profile name
}
