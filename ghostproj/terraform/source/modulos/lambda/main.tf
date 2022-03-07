resource "aws_lambda_function" "test_lambda" {
  filename      = "function.zip"
  function_name = "lambda2_function_name"
  role          = var.aws_iam_lambda_role
  handler       = "handler.lambda_handler"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("function.zip")

  runtime = "python3.7"

  environment {
    variables = {
      foo = "bar"
    }
  }
}   