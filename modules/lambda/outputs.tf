output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.image_processing.function_name
}

output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.image_processing.arn
}