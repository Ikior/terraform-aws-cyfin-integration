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
  # This source path assumes your GitHub organization is 'lkior'.
  source = "lkior/cyfin-integration/aws"
  
  # You must create a v1.0.0 release on GitHub for this to work.
  version = "1.0.0"

  # Get this value from the "Connect Account" page in your CyFin dashboard.
  external_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}