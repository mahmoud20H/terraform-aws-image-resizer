## variables.tf

variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used for tagging and naming resources."
  type        = string
  default     = "serverless-image-processing"
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "original_bucket_name" {
  description = "Name of the S3 bucket for original images"
  type        = string
}

variable "processed_bucket_name" {
  description = "Name of the S3 bucket for processed images"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function for image processing"
  type        = string
  default     = "image-processing-lambda"
}

variable "lambda_runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
  default     = "nodejs18.x"
}

variable "lambda_memory_size" {
  description = "Memory size for the Lambda function in MB"
  type        = number
  default     = 512
}

variable "lambda_timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
  default     = 60
}

variable "image_sizes" {
  description = "List of image sizes to generate (width in pixels)"
  type        = list(number)
  default     = [320, 640, 1024]
}

variable "watermark_text" {
  description = "Text to use as watermark"
  type        = string
  default     = "Processed"
}