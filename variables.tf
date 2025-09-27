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
  default = "TB-AWS-SS-Dev"  # 👈 AWS CLI profile name
}

variable "subnet_id" {
  description = "The subnet ID where EC2 should be launched"
  default     = "subnet-0e71381a11f27c2c4" # replace with your subnet
}

variable "security_group_id" {
  description = "Security group for EC2"
  default     = "sg-0cf62ab6398dbaba9" # replace with your SG
}
