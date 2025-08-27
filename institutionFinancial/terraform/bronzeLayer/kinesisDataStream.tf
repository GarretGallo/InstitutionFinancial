#transactionsStream
resource "aws_kinesis_stream" "transactionsStream" {
  name = "transactionsStream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Product = "transactions"
  }
}

#customersStream
resource "aws_kinesis_stream" "customersStream" {
  name = "customersStream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Product = "customers"
  }
}

#accountsStream
resource "aws_kinesis_stream" "accountsStream" {
  name = "accountsStream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Product = "accounts"
  }
}

#employeeStream
resource "aws_kinesis_stream" "employeeStream" {
  name = "employeeStream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Product = "employee"
  }
}

#branchStream
resource "aws_kinesis_stream" "branchStream" {
  name = "branchStream"
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }

  tags = {
    Product = "branch"
  }
}