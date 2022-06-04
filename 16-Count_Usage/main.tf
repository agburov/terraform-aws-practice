provider "aws" {}

variable "aws_users" {
  description = "List of IAM users"
  default     = ["user1", "user2", "user3", "user4"]
}

#Add all users from variable list
resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}


#Auto increment of server number from counter index starting from 1
resource "aws_instance" "server" {
  count         = 3
  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t2.micro"

  tags = {
    Name = "Server Number ${count.index + 1}"
  }
}
