# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# This module from the official Terraform AWS provider does the heavy lifting
# of creating the IAM role according to best practices.
module "iam_role_for_cyfin" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role"
  version = "5.39.1" # Pinning the version ensures stability

  role_name = "CyFin-ReadOnly-Role"

  # This is the most critical security part. It defines who can assume this role.
  # It allows YOUR AWS account to assume the role, but ONLY if they provide the
  # correct external_id that your application generated.
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Principal = {
          # IMPORTANT: Replace with YOUR backend's AWS Account ID
          AWS = "arn:aws:iam::123456789012:root"
        },
        Condition = {
          StringEquals = { "sts:ExternalId" = var.external_id }
        }
      }
    ]
  })

  # Attach the standard, pre-built AWS read-only policies.
  # This grants CyFin permission to list and describe your resources without
  # being able to change anything.
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
  ]
}
