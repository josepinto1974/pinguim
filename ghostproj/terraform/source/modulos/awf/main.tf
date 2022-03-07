/* resource "aws_waf_web_acl" "waf_acl" {
  depends_on = [ 
     aws_waf_rule.waf_rule,
     aws_waf_ipset.ipset,
      ]
  name        = var.web_acl_name
  metric_name = var.web_acl_metics
 
  default_action {
    type = "ALLOW"
  }
  rules {
    action {
      type = "BLOCK"
    }
    priority = 1
    rule_id  = aws_waf_rule.waf_rule.id
    type     = "REGULAR"
 }
} */



#https://registry.terraform.io/providers/babylonhealth/aws-babylon/latest/docs/resources/waf_web_acl

/* 
resource "aws_waf_ipset" "ipset" {
  name = "tfIPSet"

  ip_set_descriptors {
    type  = "IPV4"
    value = "192.0.7.0/24"
  }
}

resource "aws_waf_rule" "wafrule" {
  depends_on  = ["aws_waf_ipset.ipset"]
  name        = "tfWAFRule"
  metric_name = "tfWAFRule"

  predicates {
    data_id = "${aws_waf_ipset.ipset.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_waf_web_acl" "waf_acl" {
  depends_on  = ["aws_waf_ipset.ipset", "aws_waf_rule.wafrule"]
  name        = "tfWebACL"
  metric_name = "tfWebACL"

  default_action {
    type = "ALLOW"
  }

  rules {
    action {
      type = "BLOCK"
    }

    priority = 1
    rule_id  = "${aws_waf_rule.wafrule.id}"
    type     = "REGULAR"
  }
}
 */
#####################################
#https://docs.fugue.co/FG_R00500.html
/* resource "aws_wafv2_web_acl" "valid1" {
  name        = "valid1"
  scope       = "CLOUDFRONT"

  rule {
    name     = "valid1rule1"
    priority = 1

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
  }
  # other required fields here
}
 */



########################



resource "aws_wafv2_web_acl" "cdbpinguim" {
    name        = "foo"
    description = "foo"
    scope       = "REGIONAL"
    default_action {
        block {}
    }
    rule {
      name = "AWSManagedRulesCommonRuleSet"
      priority = 0
      override_action {
        count {}
      }
      statement {
        managed_rule_group_statement {
          name = "AWSManagedRulesCommonRuleSet"
          vendor_name = "AWS"
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                 = "name_WSManagedRulesLinuxRuleSet"
        sampled_requests_enabled   = true
      }
    }
  
    visibility_config {
      metric_name = "foo"
      sampled_requests_enabled = false
      cloudwatch_metrics_enabled = false
    }   

      rule {
    name     = "name_WSManagedRulesLinuxRuleSet"
    priority = 1

    action {
      count {}
    }

    statement {
      rate_based_statement {
        limit              = 10000
        aggregate_key_type = "IP"

        scope_down_statement {
          geo_match_statement {
            country_codes = ["US", "NL"]
          }
        }
      }
    }
    visibility_config {
      metric_name = "IP"
      sampled_requests_enabled = false
      cloudwatch_metrics_enabled = false
    }   
      }
}

/* resource "aws_wafv2_web_acl" "example" {
  name        = "managed-rule-example"
  description = "Example of a managed rule."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "rule-1"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"

        excluded_rule {
          name = "SizeRestrictions_QUERYSTRING"
        }

        excluded_rule {
          name = "NoUserAgent_HEADER"
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "friendly-rule-metric-name"
      sampled_requests_enabled   = false
    }
  }

  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }

  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "friendly-metric-name"
    sampled_requests_enabled   = false
  }
} */ 