#Loosely based on example from AWS provider documentation
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function#example-usage
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda_execution_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_lambda_function" "hello_world" {
  function_name = "hello_world_dangamboa_lambda"
  runtime       = "python3.12"
  handler       = "lambda.lambda_handler"
  role          = aws_iam_role.lambda_role.arn

  #Save lambda code in s3 bucket
  s3_bucket = var.s3_bucket
  s3_key    = "lambda/hello_world_lambda.zip"

  #This will validate if lambda was modified to trigger terraform to update resource
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_apigatewayv2_api" "http_api" {
  name          = "hello_world_dangamboa_api"
  protocol_type = "HTTP"

}

resource "aws_apigatewayv2_integration" "integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.hello_world.invoke_arn
}

resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "GET /"
  target    = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.http_api.id
  name        = "hello_world_dangamboa_stage"
  auto_deploy = true
}

resource "aws_lambda_permission" "api_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*"
}
