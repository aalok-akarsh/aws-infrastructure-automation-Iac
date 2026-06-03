# Security Groups Module - Reusable security group definitions

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where security groups will be created"
}

variable "project_name" {
  type        = string
  description = "Project name for tagging"
}

# Web Security Group (HTTP/HTTPS)
resource "aws_security_group" "web" {
  name        = "${var.environment}-web-sg"
  description = "Security group for web servers (HTTP/HTTPS)"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment}-web-sg"
  }
}

# Allow HTTP
resource "aws_security_group_rule" "web_http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "HTTP from anywhere"
}

# Allow HTTPS
resource "aws_security_group_rule" "web_https_ingress" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "HTTPS from anywhere"
}

# Allow all outbound traffic
resource "aws_security_group_rule" "web_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web.id
  description       = "All outbound traffic"
}

# SSH Security Group
resource "aws_security_group" "ssh" {
  name        = "${var.environment}-ssh-sg"
  description = "Security group for SSH access"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment}-ssh-sg"
  }
}

# Allow SSH (restrict to your IP for production)
resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["106.192.200.177/32"]  # Restricted to user's IP
  security_group_id = aws_security_group.ssh.id
  description       = "SSH access - RESTRICTED"
}

# Allow all outbound
resource "aws_security_group_rule" "ssh_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ssh.id
  description       = "All outbound traffic"
}

# Application Security Group (for internal communication)
resource "aws_security_group" "app" {
  name        = "${var.environment}-app-sg"
  description = "Security group for application servers"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.environment}-app-sg"
  }
}

# Allow from web security group
resource "aws_security_group_rule" "app_from_web" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.web.id
  security_group_id        = aws_security_group.app.id
  description              = "App port from web servers"
}

# Allow all outbound
resource "aws_security_group_rule" "app_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.app.id
  description       = "All outbound traffic"
}

# Outputs
output "web_security_group_id" {
  value       = aws_security_group.web.id
  description = "Web security group ID"
}

output "ssh_security_group_id" {
  value       = aws_security_group.ssh.id
  description = "SSH security group ID"
}

output "app_security_group_id" {
  value       = aws_security_group.app.id
  description = "Application security group ID"
}
