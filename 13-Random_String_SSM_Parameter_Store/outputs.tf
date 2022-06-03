output "get_saved_db_password" {
  description = "Get saved password from AWS Systems Manager"
  value       = nonsensitive(data.aws_ssm_parameter.stored_db_password.value)
}
