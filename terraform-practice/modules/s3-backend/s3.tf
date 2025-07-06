# Створюємо S3-бакет
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "lesson-5"
  }
}

# Налаштовуємо версіонування для S3-бакета
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Встановлюємо контроль власності для S3-бакета
resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

########################
# 1. The bucket itself #
########################
resource "aws_s3_bucket" "logs" {
  bucket = "${var.bucket_name}-logs"
}

#########################################################
# 2. Attach the lifecycle configuration to that bucket #
#########################################################
resource "aws_s3_bucket_lifecycle_configuration" "logs_lc" {
  bucket = aws_s3_bucket.logs.id   # tie the rule to the bucket

  rule {
    id     = "log-expiration"
    status = "Enabled"             # values are "Enabled" or "Disabled"

    # empty filter block == apply to every object
    filter {}

    expiration {
      days = 30                    # delete objects after 30 days
    }
  }
}