provider "aws" {}

variable "aws_users" {
  description = "List of IAM users"
  default     = ["user1", "usr2", "use3", "user4"]
}

#Add all users to IAM from variable list
resource "aws_iam_user" "users" {
  count = length(var.aws_users)
  name  = element(var.aws_users, count.index)
}

output "created_iam_users_ids" {
  value = aws_iam_user.users[*].id
}

output "created_iam_users_arn" {
  value = [
    for user in aws_iam_user.users :
    "${user.name} has ARN: ${user.arn}"
  ]
}

output "created_iam_users_map" {
  value = {
    for user in aws_iam_user.users :
    user.name => user.arn
  }
}

output "if_name_length" {
  value = [
    for user in aws_iam_user.users :
    user.name
    if length(user.name) == 4
  ]
}
