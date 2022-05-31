provider "aws" {}

resource "aws_eip" "static_ip" {
  instance = aws_instance.my_ubuntu.id
}

resource "aws_instance" "my_ubuntu" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Owner       = "Arthur Burov"
    Name        = "My Server"
    Project     = "Terraform"
    Environment = "Testing"
  }
}
