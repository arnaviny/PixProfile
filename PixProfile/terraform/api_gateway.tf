# API Gateway
resource "aws_api_gateway_rest_api" "user_data_api" {
  name        = "UserDataAPI"
  description = "API for fetching user data and images"
}

# Resource for user data and images
resource "aws_api_gateway_resource" "user_data_resource" {
  rest_api_id = aws_api_gateway_rest_api.user_data_api.id
  parent_id   = aws_api_gateway_rest_api.user_data_api.root_resource_id
  path_part   = "data"
}

# Method לשליפת נתונים מ-DynamoDB
resource "aws_api_gateway_method" "get_data_method" {
  rest_api_id   = aws_api_gateway_rest_api.user_data_api.id
  resource_id   = aws_api_gateway_resource.user_data_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_data_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.user_data_api.id
  resource_id = aws_api_gateway_resource.user_data_resource.id
  http_method = aws_api_gateway_method.get_data_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_data_lambda.invoke_arn
}

# Method לקבלת תמונה מ-S3
resource "aws_api_gateway_method" "get_image_method" {
  rest_api_id   = aws_api_gateway_rest_api.user_data_api.id
  resource_id   = aws_api_gateway_resource.user_data_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_image_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.user_data_api.id
  resource_id = aws_api_gateway_resource.user_data_resource.id
  http_method = aws_api_gateway_method.get_image_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_image_lambda.invoke_arn
}

resource "aws_lambda_function" "get_data_lambda" {
  function_name = "get_data_lambda"
  handler       = "path_to_your_handler.handler"
  role          = aws_iam_role.dynamodb_lambda_role.arn
  runtime       = "python3.8"  # או כל גרסה אחרת שאתה משתמש בה

  filename = "path_to_your_lambda_package.zip"  # הנתיב לארכיון ה-ZIP של הפונקציה
}

resource "aws_lambda_function" "get_image_lambda" {
  function_name = "get_image_lambda"
  handler       = "path_to_your_handler.handler"
  role          = aws_iam_role.s3_lambda_role.arn
  runtime       = "python3.8"  # או כל גרסה אחרת שאתה משתמש בה

  filename = "path_to_your_lambda_package.zip"  # הנתיב לארכיון ה-ZIP של הפונקציה
}
