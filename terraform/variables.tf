# Global variables used across modules

variable "aws_region" {
  description = "AWS region (used by provider)"
  type        = string
  default     = "eu-central-1"
}

variable "project_name" {
  description = "Short project identifier used in resource names"
  type        = string
  default     = "localstack-tf-ghaction-pipeline"
}

variable "environment" {
  description = "Environment name (dev/test)"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Common tags map applied to all resources"
  type        = map(string)
  default     = {}
}
