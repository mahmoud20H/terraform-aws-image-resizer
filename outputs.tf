output "original_images_bucket_name" {
  description = "Name of the S3 bucket for original images"
  value       = module.s3.original_bucket_name
}

output "processed_images_bucket_name" {
  description = "Name of the S3 bucket for processed images"
  value       = module.s3.processed_bucket_name
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = module.lambda.lambda_function_arn
}