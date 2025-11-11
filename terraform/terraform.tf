############################################################
# Provider configuration
# This file configures Terraform to talk to LocalStack (a
# local AWS emulator) via custom endpoints. We also include
# the 'archive' provider for zipping lambda code.
############################################################

terraform {
  required_version = ">= 1.3.0"
}

terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 5.0"
    }

    archive = {
        source = "hashicorp/archive"
        version = "~> 2.2"
        }
  }
}
