
##################

resource "aws_route53_zone" "main" {
  name = var.domain_name
  #tags = var.common_tags
}

resource "aws_route53_record" "root-a" {
  zone_id = aws_route53_zone.main.zone_id
  name = var.domain_name
  type = "A"

  alias {
    name = var.aws_cloudfront_distributions3_distribution_domain_name
    zone_id = var.aws_cloudfront_distributions3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www-a" {
  zone_id = aws_route53_zone.main.zone_id
  name = "www.${var.domain_name}"
  type = "A"

  alias {
    name = var.aws_cloudfront_distributions3_distribution_domain_name
    zone_id = var.aws_cloudfront_distributions3_distribution_hosted_zone_id
    evaluate_target_health = false
  }
} 






/* 













resource "aws_acm_certificate" "cert" {
  domain_name               = "${var.domain_name}"
  validation_method         = "DNS"
  subject_alternative_names = "${var.san_domains}"
  provider = "aws.east"
}


resource "aws_route53_record" "cert" {
  zone_id = "${data.aws_route53_zone.zone.id}"
  name    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_name")}"
  type    = "${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_type")}"
  records = ["${lookup(aws_acm_certificate.cert.domain_validation_options[count.index], "resource_record_value")}"]
  ttl     = 60
}




resource "aws_route53_record" "root_domain" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "${var.domain}"
  type = "A"

  alias {
    name = "${aws_cloudfront_distribution.cdn.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}


# https://github.com/cloudposse/terraform-aws-cloudfront-s3-cdn/issues/109

data "aws_route53_zone" "main" {
  name         = local.domain_name
  private_zone = false
}

data "aws_acm_certificate" "certificate" {
  domain      = local.domain_name
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

/* module "cloudfront-s3-cdn" {
  source  = "cloudposse/cloudfront-s3-cdn/aws"
  version = "0.35.0"

  name                 = local.domain_name
  origin_force_destroy = true
  encryption_enabled   = true

  # DNS Settings
  parent_zone_id      = data.aws_route53_zone.main.id
  acm_certificate_arn = data.aws_acm_certificate.certificate.arn
  aliases             = [local.domain_name, "www.${local.domain_name}"]
  ipv6_enabled        = true

  # Caching Settings
  default_ttl = 300
  compress    = true

  # Website settings
  website_enabled = true
  index_document  = "index.html"
  error_document  = "index.html"

  depends_on = [data.aws_acm_certificate.certificate]
}
 

#

#https://stackoverflow.com/questions/66411564/cloudfront-redirect-using-route-53


#https://www.deployawebsite.com/static-sites/s3-terraform/dns/


#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record

resource "aws_cloudfront_distribution" "www_distribution" {

  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }

   
    domain_name = aws_s3_bucket.www.website_endpoint
    origin_id   = var.www_domain_name
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = var.www_domain_name
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

 
  aliases = [ var.www_domain_name ]

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

 
  viewer_certificate {
    acm_certificate_arn = aws_acm_certificate.certificate.arn
    ssl_support_method  = "sni-only"
  }
}



resource "aws_route53_zone" "zone" {
  name = var.root_domain_name
}





######################



resource "aws_route53_zone" "route_zone" {
  name = "${var.domain}"
}

resource "aws_acm_certificate" "domain_virginia" {
  provider = "aws.virginia"
  domain_name = "${var.domain}"
  validation_method = "DNS"
}

resource "aws_route53_record" "cert_validation_virginia" {
  name = "${aws_acm_certificate.domain_virginia.domain_validation_options.0.resource_record_name}"
  type = "${aws_acm_certificate.domain_virginia.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.domain_virginia.domain_validation_options.0.resource_record_value}"]
  zone_id = "${aws_route53_zone.route_zone.zone_id}"
  ttl = 60
}

resource "aws_acm_certificate_validation" "cert_validation_virginia" {
  provider = "aws.virginia"
  certificate_arn = "${aws_acm_certificate.domain_virginia.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation_virginia.fqdn}"]
}





data "aws_route53_zone" "zone" {
  name         = "${var.root_domain_name}."
  private_zone = false
}

resource "aws_route53_record" "cert_validation" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.0.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}

resource "aws_route53_record" "cert_validation_www" {
  name    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_name}"
  type    = "${aws_acm_certificate.cert.domain_validation_options.1.resource_record_type}"
  zone_id = "${data.aws_route53_zone.zone.id}"
  records = ["${aws_acm_certificate.cert.domain_validation_options.1.resource_record_value}"]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = "${aws_acm_certificate.cert.arn}"
  validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}", "${aws_route53_record.cert_validation_www.fqdn}"]
} 



#https://github.com/conortm/terraform-aws-s3-static-website/blob/master/main.tf

#https://github.com/conortm/terraform-aws-s3-static-website/blob/master/main.tf



#https://stackoverflow.com/questions/56565194/terraform-route53-lb-and-cdn-interdependency
resource "aws_route53_record" "www" {
  count = "${var.domain-name != "" ? 1 : 0}"

  depends_on = ["aws_lb.alb", "aws_cloudfront_distribution.cdn"]  

  zone_id = "${data.aws_route53_zone.primary.zone_id}"
  name    = "${var.domain-name}"
  type    = "A"

  alias = {
    // we use concat because 'count' makes the response of the resource a list. 
    // link to similar issue: https://stackoverflow.com/questions/45654774/terraform-conditional-resource
    name                   = "${var.use_cloudfront == "true" ? element(concat(aws_cloudfront_distribution.cdn.*.domain_name, list("")), 0) : aws_lb.alb.dns_name}"    
    zone_id                = "${var.use_cloudfront == "true" ? element(concat(aws_cloudfront_distribution.cdn.*.hosted_zone_id, list("")), 0) : aws_lb.alb.zone_id}"
    evaluate_target_health = true
  }
}


#https://www.alexhyett.com/terraform-s3-static-website-hosting
#vital

#https://www.alexhyett.com/terraform-s3-static-website-hosting

# https://maxrozen.com/start-your-own-app-with-react-part-2 */