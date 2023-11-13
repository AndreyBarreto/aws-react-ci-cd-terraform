
resource "aws_cloudfront_origin_access_control" "cloudfront_acl" {
  name = "ACL - TESTE"

  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cloudfront" {
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CDN for TERRAFORM"
  default_root_object = "index.html"
  http_version        = "http2"


  origin {
    origin_id                = aws_s3_bucket.bucket.id
    origin_access_control_id = aws_cloudfront_origin_access_control.cloudfront_acl.id
    domain_name              = aws_s3_bucket.bucket.bucket_regional_domain_name
  }

  default_cache_behavior {
    target_origin_id = aws_s3_bucket.bucket.id

    compress        = true
    allowed_methods = var.cloudfront_allowed_methods
    cached_methods  = var.cloudfront_cached_methods

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false

    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"

    acm_certificate_arn = aws_acm_certificate_validation.certificate_validation.certificate_arn
  }

  depends_on = [
    aws_s3_bucket.bucket
  ]
}
