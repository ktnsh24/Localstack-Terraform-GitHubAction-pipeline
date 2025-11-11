# AWS provider configured to point to LocalStack.
# - access_key/secret are dummy values used by LocalStack.
# - skip_* flags avoid provider trying to validate account on AWS.
# - endpoints block maps AWS services to LocalStack's edge URL.



provider "aws" {
  region                      = var.aws_region                         # Which AWS region to emulate
  access_key                  = "test"                                  # dummy credential for LocalStack
  secret_key                  = "test"                                  # dummy credential for LocalStack
  skip_credentials_validation = true                                    # don't validate creds with real AWS
  skip_requesting_account_id  = true                                    # don't fetch account id
  s3_force_path_style         = true                                    # use path style (LocalStack expects this)
  endpoints {
    # All endpoints go to the LocalStack edge port 4566
    s3        = "http://localhost:4566"
    sqs       = "http://localhost:4566"
    dynamodb  = "http://localhost:4566"
    iam       = "http://localhost:4566"
    lambda    = "http://localhost:4566"
    cloudwatch = "http://localhost:4566"
    logs       = "http://localhost:4566"

    # Default tags applied to all resources
    default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
      Region      = var.aws_region
        }
                }

    }
}

provider "docker" {
    host = "unix:///Users/ketansahu/.docker/run/docker.sock"
}

