variable "function_name" {
  description = "Lambda function name"
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN the Lambda will assume"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket name the Lambda writes to"
  type        = string
}

variable "dynamodb_table" {
  description = "DynamoDB table name the Lambda writes into"
  type        = string
}

variable "sqs_queue_arn" {
  description = "SQS queue ARN used as event source"
  type        = string
}

variable "tags" {
  description = "Tags for Lambda"
  type        = map(string)
  default     = {}
}
