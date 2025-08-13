# C:\IKIOR\terraform-aws-cyfin-integration\main.tf (Corrected Version)

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# This is the corrected community module block.
# It now points to the correct 'iam-assumable-role' submodule.
module "cyfin_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.39.1" # Pinning the version ensures stability

  # The name of the role that will be created in the user's account
  role_name = "CyFin-ReadOnly-Role"
  
  # A list containing YOUR AWS Account ID. This is who is trusted.
  trusted_role_arns = [
    "arn:aws:iam::123456789012:root" # IMPORTANT: Replace with YOUR backend's AWS Account ID
  ]

  # This is the critical security condition.
  # It ensures the role can only be assumed if your app provides the correct secret ID.
  custom_role_trust_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { AWS = "arn:aws:iam::123456789012:root" }, # Replace with YOUR AWS Account ID
        Condition = {
          StringEquals = { "sts:ExternalId" = var.external_id }
        }
      }
    ]
  })

  # Attach the standard, pre-built AWS read-only policies.
  managed_policy_arns = [
    "arn:aws:iam::aws:policy/SecurityAudit",
    "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
  ]
}
