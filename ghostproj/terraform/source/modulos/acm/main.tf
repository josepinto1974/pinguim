provider "aws" {
  alias = "acm_provider"
  region = "us-east-1"
}


resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.domain_name}"
  validation_method         = "DNS"
  provider = aws.acm_provider
}


resource "aws_acm_certificate_validation" "cert" {
    provider = aws.acm_provider
    certificate_arn = aws_acm_certificate.cert.arn
   # validation_record_fqdns = ["${aws_route53_record.cert.*.fqdn}" ]
}