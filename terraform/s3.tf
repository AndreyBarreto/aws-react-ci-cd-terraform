resource "aws_s3_bucket" "my_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true


  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}
