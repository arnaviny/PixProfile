


resource "aws_lambda_function" "save_data_lambda" {
  function_name = "SaveDataLambda"
  handler       = "save_to_dynamodb.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.dynamodb_lambda_role.arn
  filename      = "save_to_dynamodb.zip"  # קובץ ה-ZIP של הפונקציה
}

resource "aws_lambda_function" "get_data_lambda" {
  function_name = "GetDataLambda"
  handler       = "get_data_from_dynamodb.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.dynamodb_lambda_role.arn
  filename      = "get_data_from_dynamodb.zip"  # קובץ ה-ZIP של הפונקציה
}
