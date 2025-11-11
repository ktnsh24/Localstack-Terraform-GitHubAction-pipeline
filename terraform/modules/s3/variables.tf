variable "bucket_name" {
  description = "S3 bucket name to create"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
