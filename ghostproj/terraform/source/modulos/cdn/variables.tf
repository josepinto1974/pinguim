/* variable "aws_alb_id" {
  type = string
  default = "ec2nome"
}


variable "aws_alb_dns" {
  type = string
  default = "ec2nome"
} */


variable "aws_lb_main_id" {
  type = string
  default = "ec2nome"
}



variable "aws_lb_main_dns_name" {
  type = string
  default = "ec2nome"
}

variable "aws_acm_certificate_validation_cert_certificate_arn" {
  type = string
  default = "ecvvv2nome"
}


variable "aws_wafv2_web_acl_cdbpinguim_arn" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  #default     = "ExampleAppServerInstance"
}
