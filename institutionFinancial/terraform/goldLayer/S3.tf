#transactionsGold
resource "aws_s3_bucket" "transactionsGold" {
  bucket = "transactionsGold"

  tags = {
    Product = "transactions"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "transactionsGoldLCP" {
  bucket = aws_s3_bucket.transactionsGold.id

  rule {
    id = "rule-1"
    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#customersGold
resource "aws_s3_bucket" "customersGold" {
  bucket = "customersGold"

  tags = {
    Product = "customers"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "customersGoldLCP" {
  bucket = aws_s3_bucket.customersGold.id

  rule {
    id = "rule-1"
    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#accountsGold
resource "aws_s3_bucket" "accountsGold" {
  bucket = "accountsGold"

  tags = {
    Product = "accounts"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "accountsGoldLCP" {
  bucket = aws_s3_bucket.accountsGold.id

  rule {
    id = "rule-1"
    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#employeeGold
resource "aws_s3_bucket" "employeeGold" {
  bucket = "employeeGold"

  tags = {
    Product = "employee"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "employeeGoldLCP" {
  bucket = aws_s3_bucket.employeeGold.id

  rule {
    id = "rule-1"
    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}

#branchGold
resource "aws_s3_bucket" "branchGold" {
  bucket = "branchGold"

  tags = {
    Product = "branch"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "branchGoldLCP" {
  bucket = aws_s3_bucket.branchGold.id

  rule {
    id = "rule-1"
    transition {
      days = 60
      storage_class = "INTELLIGENT_TIERING"
    }
    status = "Enabled"
  }
}