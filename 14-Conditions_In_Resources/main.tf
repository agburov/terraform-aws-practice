provider "aws" {}

variable "env" {
  default = "prod"
}

variable "prod_owner" {
  default = "A.Burov"
}

variable "other_owner" {
  default = "No name"
}

resource "aws_instance" "web_server" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.env == "prod" ? "t3.large" : "t2.micro"

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.other_owner
  }
}

#An additional server is created for the dev environment
#Otherwise no one will be created
resource "aws_instance" "dev_server" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
}
