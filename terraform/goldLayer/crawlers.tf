#Silver to Gold
data "aws_s3_bucket" "transactions_silver" { bucket = "transactions-silver" }
data "aws_s3_bucket" "customers_silver"    { bucket = "customers-silver" }
data "aws_s3_bucket" "accounts_silver"     { bucket = "accounts-silver" }


resource "aws_glue_crawler" "accountsGoldCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "accounts-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.customers_silver.bucket}"
  }
}

resource "aws_glue_crawler" "transactionsGoldCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "transactions-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.transactions_silver.bucket}"
  }
}

resource "aws_glue_crawler" "customersGoldCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "customers-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${data.aws_s3_bucket.customers_silver.bucket}"
  }
}

#Aggregation Crawlers
resource "aws_glue_crawler" "transactionsAggCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "transactions-agg-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.transactionsGold.bucket}"
  }
}

resource "aws_glue_crawler" "customersAggCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "customer-agg-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.customersGold.bucket}"
  }
}

resource "aws_glue_crawler" "accountsAggCrawler" {
  database_name = aws_glue_catalog_database.goldDatabase.name
  name          = "accounts-agg-crawler"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${aws_s3_bucket.accountsGold.bucket}"
  }
}