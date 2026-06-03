output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "public_subnet_id" {
  value       = module.vpc.public_subnet_id
  description = "Public subnet ID"
}

output "private_subnet_id" {
  value       = module.vpc.private_subnet_id
  description = "Private subnet ID"
}

output "internet_gateway_id" {
  value       = module.vpc.internet_gateway_id
  description = "Internet Gateway ID"
}

output "vpc_cidr" {
  value       = module.vpc.vpc_cidr
  description = "VPC CIDR block"
}

# Security Groups
output "web_security_group_id" {
  value       = module.security_groups.web_security_group_id
  description = "Web security group ID (HTTP/HTTPS)"
}

output "ssh_security_group_id" {
  value       = module.security_groups.ssh_security_group_id
  description = "SSH security group ID"
}


output "app_security_group_id" {
  value       = module.security_groups.app_security_group_id
  description = "Application security group ID"
}