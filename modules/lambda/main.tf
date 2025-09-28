data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/lambda_function"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "image_processing" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = var.function_name
  role            = var.role_arn
  handler         = "index.handler"
  runtime         = var.runtime
  memory_size     = var.memory_size
  timeout         = var.timeout
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      PROCESSED_BUCKET = var.processed_bucket
      IMAGE_SIZES      = jsonencode(var.image_sizes)
      WATERMARK_TEXT   = var.watermark_text
    }
  }

  tags = {
    Name        = "${var.project_name}-lambda-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }

  depends_on = [
    aws_cloudwatch_log_group.lambda_logs
  ]
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14

  tags = {
    Name        = "${var.project_name}-lambda-logs-${var.environment}"
    Environment = var.environment
    Project     = var.project_name
  }
}