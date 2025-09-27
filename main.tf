provider "aws" {
  region  = var.region
  profile = var.aws_profile   # 👈 use profile instead of keys
}

resource "aws_instance" "jenkins_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "jenkins-profile-ec2"
  }
}
