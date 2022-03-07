terraform {
   backend "s3" {
    bucket = "scib-sigom-terraform"
    key    = "terraform-teste-fp_awsse.tfstate"
    region = "eu-west-2"
    profile = "cross"
  }
}

#####


provider "aws" {
  profile    = "cross"
  region     = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::920768381054:role/SysOps"
  }
}

##1 criar dominio
##usar uma VPC temos de faer oupput do id da vpc e das subnets

##pedido ao espinhos a adicao da permisoes na policy 

####################criacao do dominio

resource "aws_elasticsearch_domain" "crossteam" {
  domain_name           = "integritycheckcrosstream"
  elasticsearch_version = "7.9"

   advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
    # "rest.action.multi.allow_explicit_index" = true
    # "indices.fielddata.cache.size" = 40
  }




  cluster_config {
    instance_type = "m4.large.elasticsearch"
    instance_count = 4
    zone_awareness_enabled = true
  }


   ebs_options {
    ebs_enabled = true
    volume_size = 20
    volume_type = "gp2"
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

 

}

###########################################fim criacao do dominio


#####aws_elasticsearch_domain_policy



resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = "${aws_elasticsearch_domain.crossteam.domain_name}"

  access_policies = <<POLICIES
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
            },
            "Resource": "${aws_elasticsearch_domain.example.arn}/*"
        }
    ]
}
POLICIES
}


#####fim aws_elasticsearch_domain_policy

####criacao policy 


variable "domain" {
  default = "tf-test"
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_elasticsearch_domain" "example" {
  domain_name = "${var.domain}"
  # ... other configuration ...

  access_policies = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "es:*",
      "Principal": "*",
      "Effect": "Allow",
      "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*",
      "Condition": {
        "IpAddress": {"aws:SourceIp": ["66.193.100.22/32"]}
      }
    }
  ]
}
POLICY
}
 #m4.large.elasticsearch
#########################################

####Log Publishing to CloudWatch Logs




#####fimLog Publishing to CloudWatch Logs


###VPC comentado
/* 
variable "vpc" {}



data "aws_vpc" "selected" {
  tags {
    Name = "${var.vpc}"
  }
}

data "aws_subnet_ids" "selected" {
  vpc_id = "${data.aws_vpc.selected.id}"

  tags {
    Tier = "private"
  }
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

resource "aws_security_group" "es" {
  name        = "${var.vpc}-elasticsearch-${var.domain}"
  description = "Managed by Terraform"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.selected.cidr_blocks}",
    ]
  }
}

resource "aws_iam_service_linked_role" "es" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "${var.domain}"
  elasticsearch_version = "6.3"

  cluster_config {
    instance_type = "m4.large.elasticsearch"
  }

  vpc_options {
    subnet_ids = [
      "${data.aws_subnet_ids.selected.ids[0]}",
      "${data.aws_subnet_ids.selected.ids[1]}",
    ]

    security_group_ids = ["${aws_security_group.elasticsearch.id}"]
  }

  advanced_options = {
    "rest.action.multi.allow_explicit_index" = "true"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:domain/${var.domain}/*"
        }
    ]
}
CONFIG

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Domain = "TestDomain"
  }

  depends_on = [
    "aws_iam_service_linked_role.es",
  ]
} */

###FIM VPC