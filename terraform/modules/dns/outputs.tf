output "fqdn_name" {
  value = aws_route53_zone.main.name
}
output "certificate_arn" {
  value = aws_acm_certificate.wildcard.arn
}
