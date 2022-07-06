provider "aws" {
  region = "us-east-1" #useful if you need to find info in different regions
}

data "aws_ami" "latest_ubuntu" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-*-amd64-server-*"]
  }
}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
    # values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}

data "aws_ami" "latest_windows_2022_server" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base-*"]
  }
}
