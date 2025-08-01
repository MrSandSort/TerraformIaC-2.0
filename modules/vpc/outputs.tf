output "vpc_id" {
  value = aws_vpc.sand_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.sand_public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.sand_private_subnet.id
}
