resource "aws_s3_bucket" "bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true


  tags = {
    Name        = "MyS3Bucket"
    Environment = "Production"
  }
}


resource "aws_s3_bucket_public_access_block" "bucket_public_access" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode({
    "Version" : "2008-10-17",
    "Statement" : [
      {
        "Sid" : "AllowCloudFrontServicePrincipalReadOnly",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "cloudfront.amazonaws.com",
        },
        "Action" : "s3:GetObject",
        "Resource" : "arn:aws:s3:::${aws_s3_bucket.bucket.bucket}/*",
        "Condition" : {
          "StringEquals" : {
            "aws:SourceArn" : aws_cloudfront_distribution.cloudfront.arn
          }
        }
      }
    ]
  })

  depends_on = [
    aws_s3_bucket.bucket
  ]
}
