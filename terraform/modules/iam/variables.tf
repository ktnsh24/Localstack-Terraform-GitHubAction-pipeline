# Inputs for IAM module

variable "role_name" {
  description = "IAM Role name to create"
  type        = string
}

# For demo we accept wildcard ARNs (passed from root),
# but in production you'd pass explicit ARNs to scope the policy
variable "bucket_arn_wildcard" {
  description = "S3 ARN wildcard that the inline policy will allow (demo)"
  type        = string
  default     = "*"
}

variable "dynamodb_table_arn" {
  description = "DynamoDB table ARN allowed by inline policy"
  type        = string
  default     = "*"
}

variable "sqs_queue_arn" {
  description = "SQS queue ARN allowed by inline policy"
  type        = string
  default     = "*"
}

variable "tags" {
  description = "Tags to apply to the role"
  type        = map(string)
  default     = {}
}
