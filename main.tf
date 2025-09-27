
provider "aws" {
  region = "us-east-1" # <-- IMPORTANT: Change to your AWS region
}

data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-production-vpc"] # <-- CHANGE THIS to your VPC's Name tag or ID
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["my-public-subnet-a"] # <-- CHANGE THIS to your Subnet's Name tag or ID
  }
}

data "aws_security_group" "selected" {
  name   = "my-web-server-sg" # <-- CHANGE THIS to your SG's name
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
 
  public_key = file("~/.ssh/id_rsa.pub") 
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
