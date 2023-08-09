resource "aws_s3_bucket" "user_images_bucket" {
  bucket = "user-images-bucket"
  acl    = "private"
}
