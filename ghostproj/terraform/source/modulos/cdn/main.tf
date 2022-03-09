
resource "aws_route53_zone" "pinguim_hosted_zone" {
  name = var.domain_name
}


#https://www.oss-group.co.nz/blog/automated-certificates-aws

# This data source looks up the public DNS zone
/* data "aws_route53_zone" "public" {
  name         = var.domain_name
  private_zone = false
  #provider     = aws.account_route53
} */


resource "aws_acm_certificate" "myapp" {
  domain_name       = aws_route53_record.cert_validation.fqdn
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}




# This tells terraform to cause the route53 validation to happen
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.myapp.arn
  validation_record_fqdns = [ aws_route53_record.cert_validation.fqdn ]
}






# This is a DNS record for the ACM certificate validation to prove we own the domain
#
# This example, we make an assumption that the certificate is for a single domain name so can just use the first value of the
# domain_validation_options.  It allows the terraform to apply without having to be targeted.
# This is somewhat less complex than the example at https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation
# - that above example, won't apply without targeting

/* resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_name
  records         = [ tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_value ]
  type            = tolist(aws_acm_certificate.myapp.domain_validation_options)[0].resource_record_type
  zone_id  = data.aws_route53_zone.public.id
  ttl      = 60
 # provider = aws.account_route53
} */

# This tells terraform to cause the route53 validation to happen
/* resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.myapp.arn
  validation_record_fqdns = [ aws_route53_record.cert_validation.fqdn ]
} */

# Standard route53 DNS record for "myapp" pointing to an ALB
resource "aws_route53_record" "cert_validation" {
  zone_id = aws_route53_zone.pinguim_hosted_zone.zone_id
  name    = "${var.domain_name}.${aws_route53_zone.pinguim_hosted_zone.name}"
  type    = "A"
  alias {
    name = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id = var.aws_cloudfront_distributions3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
  #provider = aws.account_route53
}







resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
     domain_name = var.aws_lb_main_dns_name
    origin_id   = var.aws_lb_main_id

    s3_origin_config {
      origin_access_identity = "origin-access-identity/cloudfront/ABCDEFG1234567"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Some comment"
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = "mylogs.s3.amazonaws.com"
    prefix          = "myprefix"
  }
   web_acl_id = var.aws_wafv2_web_acl_cdbpinguim_arn
  aliases = ["mysite.example.com", "yoursite.example.com"]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.aws_lb_main_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }


  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/content/immutable/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = var.aws_lb_main_id

    forwarded_values {
      query_string = false
      headers      = ["Origin"]

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }




  # Cache behavior with precedence 1
  ordered_cache_behavior {
    #count = length(var.aws_lb_main_id)
    path_pattern     = "/content/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.aws_lb_main_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE"]
    }
  }

  tags = {
    Environment = "production"
  }

    viewer_certificate {
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
    #acm_certificate_arn   = "${aws_acm_certificate_validation.cert.certificate_arn}"

  }
}

