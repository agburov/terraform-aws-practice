provider "aws" {}

resource "aws_eip" "static_ip" {
  instance = aws_instance.webserver.id
}

resource "aws_instance" "webserver" {
  ami                    = "ami-0c4f7023847b90238"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = templatefile("user_data.sh.tpl", {
    f_name   = "Arthur",
    l_name   = "Burov",
    colegues = ["Bob", "Sveta", "Petya", "Jesica"]
  })

  tags = {
    Name = "Web Server NGINX"
  }

  lifecycle {
    # prevent_destroy = true #Instance cannot be destoryed message
    # ignore_changes = [ami, user_data] #Ignore any changes in ami and user_data
    create_before_destroy = true #create a new instance, attach elastic IP then delete the old
  }
}

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_80_443"
  }
}
