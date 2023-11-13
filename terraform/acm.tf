resource "aws_acm_certificate" "certificate" {
  domain_name               = var.root_domain_name
  subject_alternative_names = [var.root_domain_name, var.sub_domain_name]

  validation_method = "DNS"

  tags = {
    Name = "MeuCertificadoACM"
  }
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn = aws_acm_certificate.certificate.arn
  # validation_record_fqdns = [for record in aws_route53_record.certificate_records : record.fqdn]

  depends_on = [
    aws_acm_certificate.certificate
  ]

  timeouts {
    create = "10m"
  }
}
