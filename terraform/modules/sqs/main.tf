############################################################
# SQS module - create a simple standard queue.
############################################################

resource "aws_sqs_queue" "this" {
  name = var.queue_name
  # You can configure redrive_policy, visibility_timeout, etc. here.
  tags = var.tags
}

