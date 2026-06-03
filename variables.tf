variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/staging/prod)"
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  type        = string
  description = "Project name for tagging"
  default     = "aws-infrastructure-automation"
}

variable "project_short_name" {
  type        = string
  description = "Short project name for resource naming"
  default     = "iac"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR must be a valid IPv4 CIDR block."
  }
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"

  validation {
    condition     = can(cidrhost(var.public_subnet_cidr, 0))
    error_message = "Public subnet CIDR must be a valid IPv4 CIDR block."
  }
}

variable "private_subnet_cidr" {
  type        = string
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"

  validation {
    condition     = can(cidrhost(var.private_subnet_cidr, 0))
    error_message = "Private subnet CIDR must be a valid IPv4 CIDR block."
  }
}

variable "cost_center" {
  type        = string
  description = "Cost center for billing/chargeback"
  default     = "engineering"
}

variable "team" {
  type        = string
  description = "Team responsible for this infrastructure"
  default     = "devops"
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable CloudWatch monitoring and VPC Flow Logs"
  default     = true
}

variable "backup_required" {
  type        = bool
  description = "Whether backups are required for resources"
  default     = true
}
