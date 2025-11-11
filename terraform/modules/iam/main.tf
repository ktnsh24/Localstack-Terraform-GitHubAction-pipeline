############################################################
# Create an IAM role and an inline policy for the Lambda
# - This module is intentionally simple and includes an inline
#   policy that allows the Lambda to write logs, put objects
#   into S3, put items into DynamoDB and read from SQS.
############################################################

# Generate the assume role policy document which allows Lambda service to assume the role
data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]                          # Lambda needs this permission to assume the role
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]              # The AWS service principal for Lambda
    }
  }
}

# Create the IAM role resource
resource "aws_iam_role" "lambda_exec" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
  tags               = var.tags
}

# Inline policy granting specific permissions used by the demo Lambda
resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.role_name}-inline-policy"
  role = aws_iam_role.lambda_exec.id

  # We use jsonencode to build a valid JSON policy from Terraform map/list syntax
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"   # allow writing CloudWatch Logs (LocalStack doesn't enforce strict ARNs)
      },
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = var.bucket_arn_wildcard  # bucket arn passed from root (demo uses "*")
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:PutItem",
          "dynamodb:UpdateItem"
        ]
        Resource = var.dynamodb_table_arn    # table arn (demo uses "*")
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ]
        Resource = var.sqs_queue_arn         # queue arn (demo uses "*")
      }
    ]
  })
}
