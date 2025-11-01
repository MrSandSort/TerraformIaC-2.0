output "vpc_id" {
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_id
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_id
}

output "instance_public_ips" {
  value       = module.instances.public_ips
  sensitive   = false
}

output "instance_private_ips" {
  value       = module.instances.private_ip
  sensitive   = false
}
