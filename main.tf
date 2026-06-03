terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Terraform = "true"
      ManagedBy = "Terraform"
    }
  }
}

# Common locals for DRY principle
locals {
  common_tags = {
    Terraform = "true"
    ManagedBy = "Terraform"
  }

  name_prefix = "${var.environment}-${var.project_short_name}"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr              = var.vpc_cidr
  public_subnet_cidr    = var.public_subnet_cidr
  private_subnet_cidr   = var.private_subnet_cidr
  environment           = var.environment
}

# Security Groups Module
module "security_groups" {
  source = "./modules/security_groups"

  vpc_id       = module.vpc.vpc_id
  environment  = var.environment
  project_name = var.project_name
}