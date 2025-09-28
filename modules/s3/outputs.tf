output "original_bucket_name" {
  description = "Name of the S3 bucket for original images"
  value       = aws_s3_bucket.original_images_bucket.id
}

output "original_bucket_id" {
  description = "ID of the S3 bucket for original images"
  value       = aws_s3_bucket.original_images_bucket.id
}

output "original_bucket_arn" {
  description = "ARN of the S3 bucket for original images"
  value       = aws_s3_bucket.original_images_bucket.arn
}

output "processed_bucket_name" {
  description = "Name of the S3 bucket for processed images"
  value       = aws_s3_bucket.processed_images_bucket.id
}

output "processed_bucket_id" {
  description = "ID of the S3 bucket for processed images"
  value       = aws_s3_bucket.processed_images_bucket.id
}

output "processed_bucket_arn" {
  description = "ARN of the S3 bucket for processed images"
  value       = aws_s3_bucket.processed_images_bucket.arn
}