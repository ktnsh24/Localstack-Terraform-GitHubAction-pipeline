# Expose useful outputs for testing
output "s3_bucket_name" {
  description = "Name of the demo S3 bucket"
  value       = module.s3.bucket_name
}

output "dynamodb_table_name" {
  description = "Name of the demo DynamoDB table"
  value       = module.dynamodb.table_name
}

output "sqs_queue_url" {
  description = "SQS queue URL"
  value       = module.sqs.queue_url
}

output "lambda_function_name" {
  description = "Lambda function name"
  value       = module.lambda.function_name
}
