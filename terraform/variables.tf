
variable "region" {
  type    = string
  default = "us-east-1"
}

variable "s3_bucket_name" {
  type    = string
  default = "superbatata"
}

variable "root_domain_name" {
  type    = string
  default = "deyzito.cloud"
}
variable "sub_domain_name" {
  type    = string
  default = "*.deyzito.cloud"
}
variable "cloudfront_allowed_methods" {
  default = ["GET", "HEAD"]
  type    = list(string)
}
variable "cloudfront_cached_methods" {
  default = ["GET", "HEAD"]
  type    = list(string)
}
