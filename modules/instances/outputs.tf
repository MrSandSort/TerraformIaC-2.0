output "public_ips" {
  value = [for i in aws_instance.public_instances : i.public_ip]
}

output "private_ip" {
  value = aws_instance.private_instance.private_ip
}
