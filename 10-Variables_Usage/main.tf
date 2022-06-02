provider "aws" {}

data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "linux_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = var.instance_type
  monitoring             = var.allow_monitoring
  vpc_security_group_ids = ["aws_security_group.dynamic_ports"]

  # tags = var.common_tags
  tags = merge(var.common_tags, { Environment = "Stage" })
}

resource "aws_eip" "static_ip" {
  instance = aws_instance.linux_server.id

  tags = {
    Name = "Server IP"
  }
}

resource "aws_security_group" "dynamic_ports" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.allow_cidr
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
