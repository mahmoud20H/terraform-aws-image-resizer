variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime environment for the Lambda function"
  type        = string
}

variable "memory_size" {
  description = "Memory size for the Lambda function in MB"
  type        = number
}

variable "timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
}

variable "role_arn" {
  description = "ARN of the IAM role for the Lambda function"
  type        = string
}

variable "project_name" {
  description = "Name of the project, used for tagging and naming resources."
  type        = string
}

variable "environment" {
  description = "Environment (e.g., dev, staging, prod)"
  type        = string
}

variable "image_sizes" {
  description = "List of image sizes to generate (width in pixels)"
  type        = list(number)
}

variable "watermark_text" {
  description = "Text to use as watermark"
  type        = string
}

variable "original_bucket" {
  description = "Name of the S3 bucket for original images"
  type        = string
}

variable "processed_bucket" {
  description = "Name of the S3 bucket for processed images"
  type        = string
}