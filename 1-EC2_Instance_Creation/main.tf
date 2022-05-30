provider "aws" {}

resource "aws_instance" "my_ubuntu" {
  count         = 1
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Owner       = "Arthur Burov"
    Name        = "My Server"
    Project     = "Terraform"
    Environment = "Testing"
  }
}
