resource "aws_s3_bucket" "project_s3_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Environment  = var.env
  }
}

resource "aws_s3_bucket_public_access_block" "project_s3_bucket_public_access_block" {
  bucket = aws_s3_bucket.project_s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "project_s3_bucket_lifecycle_configuration" {
  bucket = aws_s3_bucket.project_s3_bucket.id

  rule {
    id      = var.s3_lifecycle_rule_id
    status  = var.s3_lifecycle_rule_status

    expiration {
      days = var.s3_lifecycle_rule_expiration
    }
  }
}

resource "aws_s3_bucket_versioning" "project_s3_bucket_versioning" {
  bucket = aws_s3_bucket.project_s3_bucket.id
  versioning_configuration {
    status = var.s3_versioning
  }
}