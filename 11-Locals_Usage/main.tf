provider "aws" {}

locals {
  project_name_with_env = "${var.project_name}-${var.environment}"
  project_owner         = "${var.project_name} belongs to ${var.owner}"
  project_head_city     = "Stockholm"
}

resource "aws_instance" "ubuntu_server" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Name    = "Web Server"
    Project = local.project_name_with_env
    Owner   = local.project_owner
    City    = local.project_head_city
  }
}
