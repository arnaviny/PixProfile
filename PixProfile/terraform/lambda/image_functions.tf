resource "aws_lambda_function" "get_image_lambda" {
  function_name = "GetImageLambda"
  handler       = "get_image_from_s3.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.s3_lambda_role.arn
  filename      = "get_image_from_s3.zip"  # קובץ ה-ZIP של הפונקציה
}

resource "aws_lambda_function" "save_image_lambda" {
  function_name = "SaveImageLambda"
  handler       = "save_image_to_s3.lambda_handler"
  runtime       = "python3.8"
  role          = aws_iam_role.s3_lambda_role.arn
  filename      = "save_image_to_s3.zip"  # קובץ ה-ZIP של הפונקציה
}
