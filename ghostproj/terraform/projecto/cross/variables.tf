
variable "subnet1" {
  type = string
  default = "wwwt2.micro"
}


variable "aws_s3_bucket" {
  type = string
  default = "wwrwt2.micro"
}

variable "fargate_memory" {
  type = string
  default = ""
}



variable "access_point" {
  type = string
  default = ""
}



variable "pinguim_ecs_task_execution_role" {
  type = string
  default = ""
}


variable "fargate_cpu" {
  type = string
  default = "wwrwt2.micro"
}

variable "container_port" {
  type = string
  default = "80"
}



variable "subnet2" {
  type = string
  default = "wwwt2.micro"
}


variable "snapshot" {
  type = string
  default = "wwwt2.micro"
}

variable "final_snapshot" {
  type = string
  default = "wwwt2.micro"
}



variable "aws_iam_role_ecs-autoscale-role" {
  type = string
  default = "aws_iam_role_ecs-autoscale-role"
}


variable "autoscaling_scale_in_cooldown" {
  type = string
  default = "wwwt2.micro"
}



variable "autoscaling_scale_out_cooldown" {
  type = string
  default = "wwwt2.micro"
}


variable "aws_secretsmanager_secret_version_rdspassword" {
  type = string
  default = "wwwt2.micro"
}

variable "rdspassword" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  #default     = "ExampleAppServerInstance"
}



variable "aws_iam_lambda_role" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "aws_iam_lambda_role"
}

variable "name_secrets" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "name_secrets"
}



variable "aws_wafv2_web_acl_cdbpinguim_arn" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "aws_wafv2_web_acl_cdbpinguim_arn"
}




variable "aws_iam_role_enhanced_pinguim_monitoring" {
  type = string
  default = "ec2no888888me"
}

variable "SG_RDS" {
  type = string
  default = "ec2no888888me"
}


 variable "vpc_ldap_id_p" {
  type = string
  default = ""
}

variable "aws_db_subnet_group_private" {
  type = string
  default = "wwrwt2.micro"
}

variable "cluster_name" {
  type = string
  default = "wwrwt2.micro"
}

variable "subnets_priv_id01" {
  type = string
  default = "wwrwt2.micro"
}


variable "subnets_priv_id00" {
  type = string
  default = "wwrwt2.micro"
}


variable "subnets_cross_idall" {
  type = string
  default = "subnets_cross_idall"
}


variable "subnet_cdir_subpublica_nat_azb" {
  type = string
  default = "scib-cross-vpc"
}



variable "cdir_vpc" {
  type = string
  default = "10.0.0.0/16"
}


variable "efs_name" {
  type = string
  default = "iam_role_name"
}

variable "file_system_id" {
  type = string
  default = "iam_role_name"
}


variable "access_point_id_id" {
  type = string
  default = "iam_role_name"
}

variable "iam_instance_profile" {
  type = string
  default = "iam_role_name"
}


variable "availabilityzone" {
  type = string
  default = "ec2nome"
}



variable "subnets_cross_id1" {
  type = string
  default = "ec2nome"
}


variable "subnets_cross_id0" {
  type = string
  default = "ec2nome"
}




variable "pinguim_proxy_role" {
  type = string
  default = "ec2nokkkkkkkkkme"
}



variable "rdsproxysecret" {
  type = string
  default = "ec2nome"
}

variable "sgchat" {
  type = string
  default = "809"
}

variable "key_name" {
  type = string
  default = "ec2nome"
}

variable "nome_SG_ec2" {
  type = string
  default = "L00mmmmm00LL"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "sg_ec2" {
  type = string
  default = "L00mmmmm00LL"
}
variable "associate_public_ip_address" {
  type = string
  default = "false"
}

variable "ami_id" {
  type = string
  default = "ami-0d3c032f5934e1b41"
}

variable "nome_SG_alb" {
  type = string
  default = "L00mmmmm00LL"
}

variable "nome_SG_chat" {
  type = string
  default = "L00mmmmm00LL"
}



 variable "app_image" {
  type = string
  default = "ec2nome"
}

 
variable "vpc_id" {
  type = string
  default = "ec2nome"
}


variable "alb_security_groups" {
  type = string
  default = "ec2nome"
}


variable "aws_alb_dns" {
  type = string
  default = "ec2nome"
}


variable "vpcid" {
  type = string
  default = "ec2nome"
}

variable "environment" {
  type = string
  default = "ec2nome"
}


variable "aws_security_group_ecs_tasks" {
  type = string
  default = "ec2nome"
}


variable "name" {
  type = string
  default = "ec2nome"
}


  variable "aws_cloudfront_distributions3_distribution_domain_name" {
  type = string
  default = "ec2nome"
}


variable "aws_cloudfront_distributions3_distribution_hosted_zone_id" {
  type = string
  default = "ec2nome"
}


variable "aws_acm_certificate_validation_cert_certificate_arn" {
  type = string
  default = "ec2nome"
}

variable "domain_name" {
  type = string
  default = "ec2nome"
}


variable "aws_lb_main_id" {
  type = string
  default = "ec2nome"
}



variable "aws_lb_main_dns_name" {
  type = string
  default = "ec2nome"
}

variable "aws_alb_id" {
  type = string
  default = "ec2nome"
}




variable "sg_efs2" {
  type = string
  default = "ec2nome"
}



variable "subnets_publica_id" {
  type = list
  default = ["000"]
}

variable "subnets_privada_id" {
  type = list
  default = ["000"]
}

variable "user_data" {
  type = string
  default = "scib-cross-services-fargate"
}

variable "ec2_name" {
  type = string
  default = "ec2nome"
}


variable "iamrole" {
  type = string
  default = "t2.micro"
}


variable "EIP" {
  type = string
  default = "ec2nome"
}


variable "lista_subids1" {
  type = string
  default = "ec2nome"
}

variable "subnet_id_puba" {
  type = string
  default = "10.0.11.0/24"
}

variable "nome_SG_bastian" {
  type = string
  default = "L00mmmmm00LL"
}


variable "dependson" {
  type = string
  default = "ec2nome"
}


variable "sgchat_ALB" {
  type = string
  default = "ec2nome"
}



variable ingress_list {
  type = map (object({
    
    fromport = string
    protocolo= string
    cdir = string

  }))
  default = {
    "one" = {
      
      fromport = "22"
      protocolo= "tcp"
      cdir= "0.0.0.0/0"
    }
      "two" = {
      
      fromport = "3389"
      protocolo= "tcp"
      cdir= "10.0.0.0/16"
    }
    "one" = {
      
      fromport = "80"
      protocolo= "tcp"
      cdir= "0.0.0.0/0"
    }
  }

}

 variable "maxstrore" {
  type = string
  default = ""
}


 variable "initialstoradge" {
  type = string
  default = ""
}