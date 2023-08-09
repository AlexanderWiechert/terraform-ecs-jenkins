resource "aws_route53_zone" "main" {
  name = "mb-${var.environment}.${var.dns_zone_name}"
}

resource "aws_route53_record" "jenkins" {
  zone_id = aws_route53_zone.main.id
  name    = "${var.service_name}.${aws_route53_zone.main.name}"
  type    = "A"
  alias {
    name                   = var.aws_dns_name
    zone_id                = var.aws_dns_zone
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard_validation" {
  for_each = {
    for dvo in aws_acm_certificate.wildcard.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.main.zone_id
}


### Set in the AWS Account where the partent zone is hosted ###
resource "aws_route53_record" "ns_main_zone_ownership" {
  provider = aws.dns_zone_holder_account
  name     = "mb-${var.environment}.${var.dns_zone_name}"
  type     = "NS"
  zone_id  = data.aws_route53_zone.main_parent_zone.zone_id
  records  = aws_route53_zone.main.name_servers
  ttl      = 300
}

data "aws_route53_zone" "main_parent_zone" {
  provider = aws.dns_zone_holder_account
  name     = var.dns_zone_name
}
