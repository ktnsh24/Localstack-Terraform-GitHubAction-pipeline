############################################################
# S3 module - creates a single S3 bucket for demo.
# Notes:
# - force_destroy = true allows Terraform to delete the bucket even if objects exist.
#   That is convenient for testing but dangerous for production.
############################################################

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name             # set final bucket name from module input
  acl    = "private"                   # make the bucket private
  force_destroy = true                 # allow deleting non-empty bucket (demo only)
  tags   = var.tags                    # apply tags
}

# Optionally create a public access block (recommended in general)
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
