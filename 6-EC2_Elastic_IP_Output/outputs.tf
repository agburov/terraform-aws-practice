
output "web_server_instance_id" {
  value       = aws_instance.my_ubuntu.id
  description = "Web Server Instance ID Information"
}

output "web_server_public_ip" {
  value = aws_eip.static_ip.public_ip
}
