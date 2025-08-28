data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "glue_crawler_role" {
  name = "glue-crawler-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "glue.amazonaws.com" },
      Action   = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "glue_crawler_s3_access" {
  name = "glue-crawler-s3-access"
  role = aws_iam_role.glue_crawler_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid: "ListBuckets",
        Effect = "Allow",
        Action = ["s3:ListAllMyBuckets"]
        Resource = "*"
      },
      {
        Sid: "ListTargetBuckets",
        Effect = "Allow",
        Action = ["s3:ListBucket"],
        Resource = [
          aws_s3_bucket.transactionsGold.arn,
          aws_s3_bucket.customersGold.arn,
          aws_s3_bucket.accountsGold.arn
        ]
      },
      {
        Sid: "ReadObjects",
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = [
          "${aws_s3_bucket.transactionsGold.arn}/*",
          "${aws_s3_bucket.customersGold.arn}/*",
          "${aws_s3_bucket.accountsGold.arn}/*"
        ]
      }
    ]
  })
}