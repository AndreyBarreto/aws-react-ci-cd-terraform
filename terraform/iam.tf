resource "aws_iam_user" "example" {
  name = "example-user"
}

resource "aws_iam_access_key" "example" {
  user = aws_iam_user.example.name
}

resource "aws_iam_user_policy_attachment" "policy-s3" {
  user       = aws_iam_user.example.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "policy-cloudfront" {
  user       = aws_iam_user.example.name
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

output "access_key_id" {
  value     = aws_iam_access_key.example.id
  sensitive = true

}

output "secret_access_key" {
  value     = aws_iam_access_key.example.secret
  sensitive = true

}
