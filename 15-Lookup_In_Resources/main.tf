provider "aws" {}

variable "env" {
  default = "prod"
}

variable "ec2-size" {
  default = {
    "prod" = "t3.medium"
    "dev"  = "t2.micro"
  }
}

variable "allow_ports" {
  default = {
    "prod" = ["80", "443"]
    "dev"  = ["80", "8080", "22"]
  }
}

#First use of lookup/map variables
resource "aws_instance" "server_1" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = lookup(var.ec2-size, var.env)

  tags = {
    Name = "${var.env}-server"
  }
}

#Other use of lookup/map variables
resource "aws_instance" "server_2" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = var.env == "prod" ? var.ec2-size["prod"] : var.ec2-size["dev"]

  tags = {
    Name = "${var.env}-server"
  }
}

#Use with security group
resource "aws_security_group" "dynamic_ports" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = lookup(var.allow_ports, var.env)
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic Security Group"
  }
}
