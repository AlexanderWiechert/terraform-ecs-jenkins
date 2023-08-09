resource "aws_acm_certificate" "wildcard" {
  domain_name       = "*.${aws_route53_zone.main.name}"
  validation_method = "DNS"
  depends_on = [
    aws_route53_zone.main
  ]
}

resource "aws_acm_certificate_validation" "jenkins" {
  certificate_arn         = aws_acm_certificate.wildcard.arn
  validation_record_fqdns = [for record in aws_route53_record.wildcard_validation : record.fqdn]
  depends_on = [
    aws_acm_certificate.wildcard
  ]
}
