terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "s3" {
  source = "./modules/s3"

  original_bucket_name  = var.original_bucket_name
  processed_bucket_name = var.processed_bucket_name
  project_name          = var.project_name
  environment           = var.environment
}

module "iam" {
  source = "./modules/iam"

  lambda_function_name = var.lambda_function_name
  project_name         = var.project_name
  environment          = var.environment

  original_bucket_arn  = module.s3.original_bucket_arn
  processed_bucket_arn = module.s3.processed_bucket_arn
}

module "lambda" {
  source = "./modules/lambda"

  function_name    = var.lambda_function_name
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout
  role_arn         = module.iam.lambda_role_arn
  project_name     = var.project_name
  environment      = var.environment
  image_sizes      = var.image_sizes
  watermark_text   = var.watermark_text
  original_bucket  = module.s3.original_bucket_name
  processed_bucket = module.s3.processed_bucket_name

  depends_on = [
    module.iam,
    module.s3
  ]
}

resource "aws_s3_bucket_notification" "original_bucket_notification" {
  bucket = module.s3.original_bucket_id

  lambda_function {
    lambda_function_arn = module.lambda.lambda_function_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "uploads/"
  }

  depends_on = [module.lambda, aws_lambda_permission.allow_s3]
}

resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "s3.amazonaws.com"
  source_arn    = module.s3.original_bucket_arn
}