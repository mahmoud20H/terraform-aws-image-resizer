variable "original_bucket_name" {
  description = "Name of the S3 bucket for original images"
  type        = string
}

variable "processed_bucket_name" {
  description = "Name of the S3 bucket for processed images"
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