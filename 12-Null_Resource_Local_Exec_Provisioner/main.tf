provider "aws" {}

resource "null_resource" "command_1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command_2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
}

resource "null_resource" "command_3" {
  provisioner "local-exec" {
    interpreter = ["python", "-c"]
    command     = "print('Hello everyone!')"
  }
}

resource "null_resource" "command_4" {
  provisioner "local-exec" {
    environment = {
      PARAM1 = "Hi"
      PARAM2 = "All"
      PARAM3 = "There!!!"
    }
    command = "echo $PARAM1 $PARAM2 $PARAM3 > params.txt"
  }
}

resource "aws_instance" "server" {
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo Web Server was created: $(date) >> log.txt"
  }
}

resource "null_resource" "command_5" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command_1, null_resource.command_2,
  null_resource.command_3, null_resource.command_4, aws_instance.server]
}
