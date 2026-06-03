# 🚀 Deployment Guide

## Prerequisites

✅ Terraform initialized  
✅ Configuration validated  
❌ AWS credentials (YOUR ACTION NEEDED)

---

## Step 1: Configure AWS Credentials

```powershell
wsl --exec bash -c "aws configure"
```

Enter when prompted:
```
AWS Access Key ID: [your-access-key-id]
AWS Secret Access Key: [your-secret-access-key]
Default region name: us-east-1
Default output format: json
```

**Verify:** 
```powershell
wsl --exec bash -c "aws sts get-caller-identity"
```

---

## Step 2: Plan the Deployment

```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform plan -out=tfplan"
```

📋 **Review the output** - shows all resources to be created

---

## Step 3: Apply the Configuration

```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform apply tfplan"
```

Or directly:
```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform apply"
```

Type `yes` to confirm

---

## Step 4: View Outputs

```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform output"
```

Will display:
- VPC ID
- Subnet IDs
- Internet Gateway ID
- CIDR blocks

---

## Verify in AWS Console

1. [VPC Dashboard](https://console.aws.amazon.com/vpc/)
2. Check:
   - ✅ VPC (10.0.0.0/16)
   - ✅ Public Subnet (10.0.1.0/24)
   - ✅ Private Subnet (10.0.2.0/24)
   - ✅ Internet Gateway attached
   - ✅ Route tables configured

---

## Cleanup (Delete Infrastructure)

```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform destroy"
```

Type `yes` to confirm deletion

---

## Troubleshooting

### AWS Credentials Not Found
```powershell
wsl --exec bash -c "aws configure"
```

### Terraform Lock Error
```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform force-unlock <LOCK_ID>"
```

### Want to Replan
```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && rm tfplan && terraform plan -out=tfplan"
```

---

## Customization

Edit `terraform.tfvars` to override defaults:

```hcl
aws_region           = "us-west-2"
environment          = "prod"
vpc_cidr             = "172.16.0.0/16"
public_subnet_cidr   = "172.16.1.0/24"
private_subnet_cidr  = "172.16.2.0/24"
```

Then apply:
```powershell
wsl --exec bash -c "cd /home/alokp/aws-infrastructure-automation-Iac && terraform apply -var-file=terraform.tfvars"
```

---

## Quick Commands Reference

| Command | Purpose |
|---------|---------|
| `terraform init` | Initialize working directory |
| `terraform validate` | Check syntax |
| `terraform plan` | Preview changes |
| `terraform apply` | Create resources |
| `terraform destroy` | Delete resources |
| `terraform state list` | Show created resources |
| `terraform state show <resource>` | Show resource details |
| `terraform refresh` | Sync state with AWS |

---

**Ready to deploy? Configure AWS credentials and run `terraform plan`!** 🎯
