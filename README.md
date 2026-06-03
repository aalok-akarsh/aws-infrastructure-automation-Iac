# AWS Infrastructure Automation - IaC with Terraform

This project provides a modular Terraform configuration for provisioning AWS infrastructure in a free-tier compatible manner.

## 📋 Project Overview

- **Framework**: Terraform >= 1.0
- **Provider**: AWS (hashicorp/aws ~> 5.0)
- **Region**: us-east-1 (default)
- **Free Tier**: ✅ Fully compatible

## 🏗️ Architecture

```
VPC (10.0.0.0/16)
├── Public Subnet (10.0.1.0/24)
│   └── Internet Gateway ↔ 0.0.0.0/0
├── Private Subnet (10.0.2.0/24)
│   └── No internet access by default
└── Route Tables
    ├── Public RT (routes to IGW)
    └── Private RT (local routes only)
```

## ✅ AWS Free Tier Compatibility

All resources used are **always free** (no time limit):
- VPC
- Subnets
- Internet Gateway
- Route Tables
- Elastic IPs (if needed in future)

⚠️ **Note**: Nat Gateway would charge ~$32/month - NOT included

## 📦 Project Structure

```
.
├── main.tf              # Root configuration & provider setup
├── variables.tf         # Root input variables
├── outputs.tf           # Root outputs
├── terraform.tfvars     # (Optional) Variable overrides
└── modules/
    └── vpc/
        ├── main.tf      # VPC resources
        ├── variables.tf # Module variables
        └── outputs.tf   # Module outputs
```

## 🚀 Quick Start

### Prerequisites

1. **AWS Account** with CLI credentials configured
   ```powershell
   aws configure
   ```

2. **Terraform Installed** (v1.0+)
   ```powershell
   terraform --version
   ```

### 1. Initialize Terraform

```powershell
terraform init
```

### 2. Plan the Infrastructure

```powershell
terraform plan -out=tfplan
```

**Review the output** - this will show all resources to be created.

### 3. Validate Configuration

```powershell
terraform validate
```

Should output: `Success! The configuration is valid.`

### 4. Apply the Configuration

```powershell
terraform apply tfplan
```

Or directly:
```powershell
terraform apply
```

**Confirmation**: Type `yes` when prompted

## 📤 Outputs

After applying, Terraform will display:

```
vpc_id               = "vpc-xxxxx"
public_subnet_id     = "subnet-xxxxx"
private_subnet_id    = "subnet-xxxxx"
internet_gateway_id  = "igw-xxxxx"
vpc_cidr             = "10.0.0.0/16"
```

## 🔍 Verify in AWS Console

1. Go to [AWS VPC Console](https://console.aws.amazon.com/vpc/)
2. Check:
   - ✅ VPC created with 10.0.0.0/16 CIDR
   - ✅ 2 Subnets (public & private)
   - ✅ Internet Gateway attached
   - ✅ Route tables configured

## 🧹 Cleanup (Delete Infrastructure)

```powershell
terraform destroy
```

Type `yes` to confirm deletion.

## 📊 AWS Manual Actions Needed

✅ **NONE** - This configuration requires no manual AWS setup!

Just configure AWS CLI credentials and run Terraform.

## 🔧 Customize Variables

Create `terraform.tfvars`:

```hcl
aws_region           = "us-west-2"
environment          = "prod"
vpc_cidr             = "172.16.0.0/16"
public_subnet_cidr   = "172.16.1.0/24"
private_subnet_cidr  = "172.16.2.0/24"
```

Then apply:
```powershell
terraform apply -var-file="terraform.tfvars"
```

## 📝 Troubleshooting

### Error: "Invalid provider version"
```powershell
terraform init -upgrade
```

### Error: "AWS credentials not found"
```powershell
aws configure
# Enter AWS Access Key ID
# Enter AWS Secret Access Key
```

### Error: "Resource already exists"
```powershell
terraform state list
terraform state rm <resource>
```

## 📚 Next Steps

- Add Security Groups for EC2 instances
- Add RDS (database) resources
- Add Load Balancers
- Set up S3 buckets
- Configure CloudFormation stacks

## 📄 License

MIT

## 👤 Author

AWS Infrastructure Automation Team