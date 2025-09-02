resource "aws_iam_role" "firehose" {
  name = "DemoFirehoseAssumeRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "firehose.amazonaws.com" }
      Action   = "sts:AssumeRole"
    }]
  })
}


resource "aws_iam_role_policy" "firehose_policy" {
  name = "FirehoseKinesisToS3Policy"
  role = aws_iam_role.firehose.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "KinesisRead"
        Effect = "Allow"
        Action = [
          "kinesis:DescribeStream",
          "kinesis:DescribeStreamSummary",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:ListShards",
          "kinesis:ListStreams"
        ]
        Resource = "*"
      },

      {
        Sid    = "S3Write"
        Effect = "Allow"
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "*"
      },

      {
        Sid    = "CWLogs"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"
        ]
        Resource = "*"
      }
    ]
  })
}

#transactionsStreamFH
resource "aws_kinesis_firehose_delivery_stream" "transactionsStreamFH" {
  name        = "transactionsStreamFH"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.transactionsBronze.arn

    buffering_size = 5
    buffering_interval = 60

  }

  kinesis_source_configuration {
    kinesis_stream_arn  = aws_kinesis_stream.transactionsStream.arn
    role_arn            = aws_iam_role.firehose.arn
  }

  tags = {
    Product = "transactions"
  }
}

#customersStreamFH
resource "aws_kinesis_firehose_delivery_stream" "customersDataStreamFH" {
  name        = "customersStreamFH"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.customersBronze.arn

    buffering_size = 5
    buffering_interval = 60

  }

  kinesis_source_configuration {
    kinesis_stream_arn  = aws_kinesis_stream.customersStream.arn
    role_arn            = aws_iam_role.firehose.arn
  }

  tags = {
    Product = "customers"
  }
}

#accountsStreamFH
resource "aws_kinesis_firehose_delivery_stream" "accountsDataStreamFH" {
  name        = "accountssStreamFH"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.accountsBronze.arn

    buffering_size = 5
    buffering_interval = 60

  }

  kinesis_source_configuration {
    kinesis_stream_arn  = aws_kinesis_stream.accountsStream.arn
    role_arn            = aws_iam_role.firehose.arn
  }

  tags = {
    Product = "accounts"
  }
}

#employeeStreamFH
resource "aws_kinesis_firehose_delivery_stream" "employeeDataStreamFH" {
  name        = "employeeStreamFH"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.employeeBronze.arn

    buffering_size = 5
    buffering_interval = 60

  }

  kinesis_source_configuration {
    kinesis_stream_arn  = aws_kinesis_stream.employeeStream.arn
    role_arn            = aws_iam_role.firehose.arn
  }

  tags = {
    Product = "employee"
  }
}

#branchStreamFH
resource "aws_kinesis_firehose_delivery_stream" "branchDataStreamFH" {
  name        = "branchStreamFH"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = aws_iam_role.firehose.arn
    bucket_arn = aws_s3_bucket.branchBronze.arn

    buffering_size = 5
    buffering_interval = 60

  }

  kinesis_source_configuration {
    kinesis_stream_arn  = aws_kinesis_stream.branchStream.arn
    role_arn            = aws_iam_role.firehose.arn
  }

  tags = {
    Product = "branch"
  }
}