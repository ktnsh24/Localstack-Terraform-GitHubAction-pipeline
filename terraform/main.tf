############################################################
# Root wiring - stitches the modules together and passes
# variables/locals from the root into each module.
############################################################

# ===== IAM module =====
# Create a role for Lambda. We pass additional ARNs to scope inline policy later.
module "iam" {
  source = "./modules/iam"

  # single role name for the lambda execution role
  role_name = "${local.name_prefix}-lambda-exec-role"

  # The S3 bucket ARN wildcard and table/queue ARNs will be set AFTER those resources are created.
  # For LocalStack demo we pass placeholders; the module's inline policy will accept these ARNs.
  bucket_arn_wildcard = "*"      # permissive for demo; tighten in real AWS
  dynamodb_table_arn  = "*"      # permissive for demo
  sqs_queue_arn       = "*"      # permissive for demo

  tags = local.common_tags
}

# ===== S3 module =====
# Create one S3 bucket. We set force_destroy = true in module for demo convenience.
module "s3" {
  source = "./modules/s3"

  bucket_name = "${local.name_prefix}-bucket"
  tags        = local.common_tags
}

# ===== DynamoDB module =====
module "dynamodb" {
  source = "./modules/dynamodb"

  table_name = "${local.name_prefix}-db-table"
  tags       = local.common_tags
}

# ===== SQS module =====
module "sqs" {
  source = "./modules/sqs"

  queue_name = "${local.name_prefix}-sqs-queue"
  tags       = local.common_tags
}

# ===== Lambda module =====
# The lambda needs: role ARN, S3 bucket name, DynamoDB table name, SQS queue ARN
module "lambda" {
  source = "./modules/lambda"

  function_name   = "${local.name_prefix}-lambda-processor"
  role_arn        = module.iam.role_arn
  s3_bucket       = module.s3.bucket_name
  dynamodb_table  = module.dynamodb.table_name
  sqs_queue_arn   = module.sqs.queue_arn

  # pass tags to Lambda
  tags = local.common_tags

  # Ensure lambda is created after the SQS/S3/DynamoDB/IAM modules
  depends_on = [
    module.iam,
    module.s3,
    module.dynamodb,
    module.sqs
  ]
}