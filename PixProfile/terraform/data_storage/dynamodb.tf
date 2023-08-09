resource "aws_dynamodb_table" "UserDataTable" {
  name           = "UserDataTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "UserID"


  attribute {
    name = "UserID"
    type = "S"
  }
}
