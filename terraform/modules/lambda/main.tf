############################################################
# Lambda module:
# - Uses the archive provider to zip the handler.py
# - Uploads the zip to Lambda using aws_lambda_function
# - Creates an event source mapping from SQS ARN -> Lambda
############################################################

# Build a zip archive containing the handler.py
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/handler.py"   # pack the handler
  output_path = "${path.module}/handler.zip"  # created artifact; Terraform reads it
}

# Create the Lambda function using the zip archive
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  filename      = data.archive_file.lambda_zip.output_path
  handler       = "handler.lambda_handler"  # module filename (handler.py) + function name
  runtime       = "python3.10"
  role          = var.role_arn              # role ARN created by IAM module
  timeout       = 30

  # Pass environment variables into the function (S3 bucket & DynamoDB table)
  environment {
    variables = {
      S3_BUCKET = var.s3_bucket
      DDB_TABLE = var.dynamodb_table
    }
  }

  # Tags for identification
  tags = var.tags
}

# Map SQS queue to Lambda: when messages arrive, Lambda is invoked
resource "aws_lambda_event_source_mapping" "sqs_to_lambda" {
  event_source_arn = var.sqs_queue_arn      # SQS queue ARN provided by SQS module
  function_name    = aws_lambda_function.this.arn
  enabled          = true
  batch_size       = 10                      # messages to send in one invocation
}

