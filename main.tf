provider "aws" {
  region = "us-east-1" 
}


variable "public_key_path" {
  description = "Path to the local public SSH key file for EC2 access."
  type        = string
  default     = "~/.ssh/id_rsa.pub" 
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-production-vpc"] # <-- VERIFY THIS TAG/NAME
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["my-public-subnet-a"] # <-- VERIFY THIS TAG/NAME
  }
}

data "aws_security_group" "selected" {
  name   = "my-web-server-sg" # <-- VERIFY THIS NAME
  vpc_id = data.aws_vpc.selected.id
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "jenkins-tf-app-key"
  # This now uses the variable defined above:
  public_key = file(var.public_key_path) 
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro" 

  subnet_id              = data.aws_subnet.selected.id
  vpc_security_group_ids = [data.aws_security_group.selected.id]
  
  associate_public_ip_address = true
  key_name                    = aws_key_pair.deployer.key_name

  tags = {
    Name = "Jenkins-TF-EC2-New-App"
  }
}

output "public_ip" {
  description = "The public IP address of the new EC2 Instance"
  value       = aws_instance.app_server.public_ip
}
