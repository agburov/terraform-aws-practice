provider "aws" {}

resource "aws_instance" "web_server_test" {
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dynamic_ports.id]

  tags = {
    Name = "Ubuntu Web Server for Test"
  }

  depends_on = [aws_instance.web_server_dev]
}

resource "aws_instance" "web_server_dev" {
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dynamic_ports.id]

  tags = {
    Name = "Ubuntu Web Server for Dev"
  }

  depends_on = [aws_instance.web_server_stage]
}

resource "aws_instance" "web_server_stage" {
  ami                    = "ami-09d56f8956ab235b3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dynamic_ports.id]

  tags = {
    Name = "Ubuntu Web Server for Stage"
  }
}

resource "aws_security_group" "dynamic_ports" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "8080", "443", "22"]
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
