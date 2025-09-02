#transactionsBronze
resource "aws_s3_bucket" "transactionsBronze" {
  bucket = "transactions-bronze"

  tags = {
    Product = "transactions"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "transactionsBronzeLCP" {
  bucket = aws_s3_bucket.transactionsBronze.id

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

#customersBronze
resource "aws_s3_bucket" "customersBronze" {
  bucket = "customers-bronze"

  tags = {
    Product = "customers"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "customersBronzeLCP" {
  bucket = aws_s3_bucket.customersBronze.id

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

#accountsBronze
resource "aws_s3_bucket" "accountsBronze" {
  bucket = "accounts-bronze"

  tags = {
    Product = "accounts"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "accountsBronzeLCP" {
  bucket = aws_s3_bucket.accountsBronze.id

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

#employeeBronze
resource "aws_s3_bucket" "employeeBronze" {
  bucket = "employee-bronze"
  tags = {
    Product = "employee"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "employeeBronzeLCP" {
  bucket = aws_s3_bucket.employeeBronze.id

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

#branchBronze
resource "aws_s3_bucket" "branchBronze" {
  bucket = "branch-bronze"

  tags = {
    Product = "branch"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "branchBronzeLCP" {
  bucket = aws_s3_bucket.branchBronze.id

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