provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-0bc691261a82b32bc" # Amazon Linux 2 (update with region-specific)
  instance_type = "t2.micro"
  key_name      = "my-key" # update with your key pair

  tags = {
    Name = "jenkins-terraform-ec2"
  }
}
