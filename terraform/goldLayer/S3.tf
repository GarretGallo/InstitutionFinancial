#transactionsGold
resource "aws_s3_bucket" "transactionsGold" {
  bucket = "transactions-gold"

  tags = {
    Product = "transactions"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "transactionsGoldLCP" {
  bucket = aws_s3_bucket.transactionsGold.id

  rule {
    id = "rule-1"

    filter {
      prefix = ""
    }

    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#customersGold
resource "aws_s3_bucket" "customersGold" {
  bucket = "customers-gold"

  tags = {
    Product = "customers"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "customersGoldLCP" {
  bucket = aws_s3_bucket.customersGold.id

  rule {
    id = "rule-1"

    filter {
      prefix = ""
    }


    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#accountsGold
resource "aws_s3_bucket" "accountsGold" {
  bucket = "accounts-gold"

  tags = {
    Product = "accounts"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "accountsGoldLCP" {
  bucket = aws_s3_bucket.accountsGold.id

  rule {
    id = "rule-1"

    filter {
      prefix = ""
    }


    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}