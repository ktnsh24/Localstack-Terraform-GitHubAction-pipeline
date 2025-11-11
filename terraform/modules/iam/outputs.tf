output "role_arn" {
  description = "ARN of the created lambda execution role"
  value       = aws_iam_role.lambda_exec.arn
}
