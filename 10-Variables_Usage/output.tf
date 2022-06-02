output "instance_id" {
  value = aws_instance.linux_server.id
}

output "server_ip" {
  value = aws_eip.static_ip.public_ip
}

output "security_group_id" {
  value = aws_security_group.dynamic_ports.id
}
