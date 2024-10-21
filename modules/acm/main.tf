resource "aws_acm_certificate" "cert" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = [
    "*.${var.domain_name}" # Wildcard domain
  ]
  tags = {
    Name = var.domain_name
  }

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "ssl" {
  for_each = {
    for option in aws_acm_certificate.cert.domain_validation_options : option.domain_name => {
      name   = option.resource_record_name
      record = option.resource_record_value
      type   = option.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = var.zone_id
}

resource "aws_acm_certificate_validation" "anitta_cloud" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.ssl : record.fqdn]
}
