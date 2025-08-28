#transactionsSilver
resource "aws_s3_bucket" "transactionsSilver" {
  bucket = "transactions-silver"

  tags = {
    Product = "transactions"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "transactionsSilverLCP" {
  bucket = aws_s3_bucket.transactionsSilver.id

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

#customersSilver
resource "aws_s3_bucket" "customersSilver" {
  bucket = "customers-silver"

  tags = {
    Product = "customers"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "customersSilverLCP" {
  bucket = aws_s3_bucket.customersSilver.id

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

#accountsSilver
resource "aws_s3_bucket" "accountsSilver" {
  bucket = "accounts-silver"

  tags = {
    Product = "accounts"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "accountsSilverLCP" {
  bucket = aws_s3_bucket.accountsSilver.id

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

#employeeSilver
resource "aws_s3_bucket" "employeeSilver" {
  bucket = "employee-silver"

  tags = {
    Product = "employee"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "employeeSilverLCP" {
  bucket = aws_s3_bucket.employeeSilver.id

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

#branchSilver
resource "aws_s3_bucket" "branchSilver" {
  bucket = "branch-silver"

  tags = {
    Product = "branch"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "branchSilverLCP" {
  bucket = aws_s3_bucket.branchSilver.id

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

#piiSilver
resource "aws_s3_bucket" "piiSilver" {
  bucket = "pii-silver"

  tags = {
    Product = "pii"
  }
}

#define lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "piiSilverLCP" {
  bucket = aws_s3_bucket.piiSilver.id

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