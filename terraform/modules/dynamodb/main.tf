############################################################
# DynamoDB module - creates a simple table with a string
# hash key named 'id'. We use PAY_PER_REQUEST billing for demo.
############################################################

resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = "PAY_PER_REQUEST"   # no capacity provisioning required for demo
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = var.tags
}

