resource "aws_s3_bucket" "original_images_bucket" {
  bucket = var.original_bucket_name

  tags = {
    Name        = "${var.project_name}-original-images-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "original_images_bucket_versioning" {
  bucket = aws_s3_bucket.original_images_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "original_images_bucket_encryption" {
  bucket = aws_s3_bucket.original_images_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "original_images_bucket_pab" {
  bucket = aws_s3_bucket.original_images_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket" "processed_images_bucket" {
  bucket = var.processed_bucket_name

  tags = {
    Name        = "${var.project_name}-processed-images-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "processed_images_bucket_versioning" {
  bucket = aws_s3_bucket.processed_images_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "processed_images_bucket_encryption" {
  bucket = aws_s3_bucket.processed_images_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "processed_images_bucket_pab" {
  bucket = aws_s3_bucket.processed_images_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}