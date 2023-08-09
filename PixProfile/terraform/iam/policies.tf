resource "aws_iam_role_policy" "dynamodb_lambda_access" {
  name   = "DynamoDBLambdaAccess"
  role   = aws_iam_role.dynamodb_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:PutItem",
          "dynamodb:GetItem"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.UserDataTable.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "s3_lambda_access" {
  name   = "S3LambdaAccess"
  role   = aws_iam_role.s3_lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:GetObject"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::user-images-bucket/*"
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_lambda_policy" {
  name        = "DynamoDBLambdaAccessPolicy"
  description = "Allows Lambda functions to access DynamoDB"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ],
        Effect   = "Allow",
        Resource = aws_dynamodb_table.UserDataTable.arn  # התייחסות דינאמית ל-ARN של הטבלה שיצרת ב-Terraform
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamodb_lambda_role_attach" {
  role       = aws_iam_role.dynamodb_lambda_role.name
  policy_arn = aws_iam_policy.dynamodb_lambda_policy.arn
}
