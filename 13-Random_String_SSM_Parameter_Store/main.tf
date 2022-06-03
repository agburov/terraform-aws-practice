provider "aws" {}

#Needed to change the db password, used in the keepers block
#Change the default value to any text to change the db password
variable "change_db_password" {
  default = "initial"
}
#Random password generator
resource "random_string" "db_password" {
  length           = 12
  special          = true
  override_special = "!#$&?"

  keepers = {
    keepeer_one = var.change_db_password
  }
}

#Save password in AWS System Manager
resource "aws_ssm_parameter" "db_password" {
  name        = "/prod/mysql"
  description = "Root password of MySQL DB"
  type        = "SecureString"
  value       = random_string.db_password.result
}

#Saved password path in AWS System Manager
data "aws_ssm_parameter" "stored_db_password" {
  name       = "/prod/mysql"
  depends_on = [aws_ssm_parameter.db_password]
}

#Creating a MySQL database instance
resource "aws_db_instance" "default" {
  identifier           = "abc-product"
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "master"
  username             = "administrator"
  password             = data.aws_ssm_parameter.stored_db_password.value
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  apply_immediately    = true
}
