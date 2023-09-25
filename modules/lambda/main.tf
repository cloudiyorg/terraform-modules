resource "aws_lambda_function" "project-lambda-function" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.project-lambda-function-iam-role.arn
  handler       = var.lambda_function_handler
  runtime       = var.lambda_function_runtime
  filename      = var.lambda_function_filename
  source_code_hash = filebase64sha256(var.lambda_function_filename)
}

resource "aws_iam_role" "project-lambda-function-iam-role" {
  name = "${var.lambda_function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "project-lambda-function-iam-policy" {
  name        = "${var.lambda_function_name}-policy"
  description = "IAM policy for Lambda function"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "logs:CreateLogGroup",
      Effect   = "Allow",
      Resource = "arn:aws:logs:${var.region}:${var.account-id}:log-group:/aws/lambda/${var.lambda_function_name}:*"
    }, {
      Action   = "logs:CreateLogStream",
      Effect   = "Allow",
      Resource = "arn:aws:logs:${var.region}:${var.account-id}:log-group:/aws/lambda/${var.lambda_function_name}:*"
    }, {
      Action   = "logs:PutLogEvents",
      Effect   = "Allow",
      Resource = "arn:aws:logs:${var.region}:${var.account-id}:log-group:/aws/lambda/${var.lambda_function_name}:*"
    }]
  })
}

resource "aws_iam_policy_attachment" "project-lambda-function-iam-policy-attachment" {
  name       = "${var.lambda_function_name}-lambda-function-iam-policy-attachment"
  policy_arn = aws_iam_policy.project-lambda-function-iam-policy.arn
  roles      = [aws_iam_role.project-lambda-function-iam-role.name]
}
