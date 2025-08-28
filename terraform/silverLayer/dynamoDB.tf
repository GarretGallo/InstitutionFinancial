resource "aws_dynamodb_table" "silverMetadata" {
  name           = "silverMetadata"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Bucket"
  range_key      = "Object"

  attribute {
    name = "Bucket"
    type = "S"
  }

  attribute {
    name = "Object"
    type = "S"
  }

  tags = {
    Product = "metadata"
  }
}