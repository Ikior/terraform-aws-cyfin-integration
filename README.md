# CyFin AWS Integration Terraform Module

[![Terraform Registry](https://img.shields.io/badge/Terraform-Registry-blue?style=flat-square)](https://registry.terraform.io/modules/cyfin/integration/aws)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=flat-square)](LICENSE)

This Terraform module creates a secure, read-only IAM Role in an AWS account. This role grants the CyFin platform the necessary permissions to scan your cloud environment for cost optimization and security insights.

The module follows security best practices by using an `External ID` to prevent the "confused deputy" problem.

## Usage

Copy the following code into your Terraform configuration (`main.tf`).

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # Configure your AWS provider as needed
}

module "cyfin_connection" {
  source = "cyfin/integration/aws"
  version = "1.0.0" # Replace with the latest version

  # Get this value from the "Connect Account" page in your CyFin dashboard.
  external_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}
```
