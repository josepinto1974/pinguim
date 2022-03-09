
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}


terraform {
   backend "s3" {
    bucket = "terraformtfstatejp"
    key    = "terraform-testeestudo.tfstate"
    region = "eu-west-3"
   
  }
}



######criacao do file de task defenition aqui porque devido ao problema o fargate é criado dentro de network

locals {
  regiao = "eu-west-3"
  
}

 locals {
  regiaoDC = "eu-west-3"
  
}

locals {
  AZregiaoDC = "eu-west-3a"
  
}

locals {
  app_image = "ghost"
  
}


locals {
  environment = "prd"
  
}



variable "priv_subnet" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "PubSub1" = {
      cidr_block        = "10.0.0.0/18"
      availability_zone = "eu-west-3a"
    }
    "PubSub2" = {
      cidr_block        = "10.0.64.0/18"
      availability_zone = "eu-west-3b"
    }
  
  }
}


variable "public_subnet" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "PubSub1" = {
      cidr_block        = "10.0.128.0/18"
      availability_zone = "eu-west-3a"
    }
    "PubSub2" = {
      cidr_block        = "10.0.192.0/18"
      availability_zone = "eu-west-3b"
    }
  
  }
}

#######################################
#####REDS

variable "rds_var" {
  type = map(object({
    availability_zone = string
  }))
  default = {
    "rdsa" = {
      
      availability_zone = "eu-west-3a"
    }
    "rdsb" = {
      
      availability_zone = "eu-west-3b"
    }
    "rdsc" = {
      
      availability_zone = "eu-west-3c"
    }
  
  }
}

locals {
  rdspassword = "testeapagar"
  
}

###Secrets RDS proxy


  module "secrets" {
  source = "../../source/modulos/secrets"
   rdspassword = local.rdspassword
   name_secrets = "rds2"
  
}  



######BOM FIM


 module "s3logvpc" {
  source = "../../source/modulos/s3"
     aws_s3_bucket = "vpcpinguim"

} 



module "iam" {
      source = "../../source/modulos/pinguimiam"
      environment = local.environment
      app_image = local.app_image
      
} 

 module "ecr" {
  source = "../../source/modulos/ecr"
   

} 

module "network" {
  source = "../../source/modulos/network"
   priv_subnet = var.priv_subnet
   public_subnet = var.public_subnet
  regiaoDC     = local.regiao
  AZregiaoDC = local.AZregiaoDC
  cdir_vpc = var.cdir_vpc
  
  subnet_cdir_subpublica_nat_aza  = "10.0.224.0/28"
  nome_vpc = "awslab-vpc"

  igw_name="pinguim_IGW"
  ###LDAP_VPC
 map_public_ip_on_launch_priv = false
 map_public_ip_on_launch_pub = true

  subnet_nome_subnetpublic_aza = "awslab-subnet-public"
  subnet_nome_subnetpriv_aza   = "awslab-subnet-private"
   aws_s3_bucket = "${module.s3logvpc.aws_s3_bucket_seb_arn}"
}

 module "SG" {
  source = "../../source/modulos/S_G"
   vpcid = "${module.network.aws_vpc_vpc_cross_id}"
   cidr_blocks = var.cdir_vpc
   name = "pinguim"
   environment = "PRD"
   
} 





module "criar_efs" {
  source = "../../source/modulos/efs"
  efs_name = "/shared"
  subnet_a = "1"
  efstags = "ems"
  
subnets_privada_id =  "${module.network.subnets_privada_id}"

 sg_efs2 = "${module.SG.aws_security_group_efs}"
access_point = "/shared"

}

/* #####bastian
##Devo fazer aqui o criacao do bastiao de modo a poder obter o ip privado e passar aos outros modulos
    module "instanciasbastian" {
    source = "../../source/modulos/ec2"
    
    amilinux_master = "ami-08b993f76f42c3e2f"
    ec2tipo = "t2.micro" 
    nome_vpc ="sigom"
    aws_vpc_vpc_cross_id = "${module.redes.aws_vpc_vpc_cross_id}"
    aws_subnet_private1_aza_id="${module.redes.aws_subnet_private1_aza_id}"


    }
 */

###fim bastian



 
locals {
  database__connection__user = "user1"
}

  module "basedados" {
  source = "../../source/modulos/rds"
  SG_RDS = "${module.SG.aws_security_group__rds}"
  aws_db_subnet_group_private="${module.network.aws_db_subnet_group_private}"   
    vpc_ldap_id_p = "${module.network.aws_vpc_vpc_cross_id}"
   rds_var = var.rds_var
   pinguim_proxy_role =  "${module.iam.aws_iam_role_secrets_policy}"
   maxstrore = "30"
   database__connection__user = local.database__connection__user
   initialstoradge = "20"
   aws_iam_role_enhanced_pinguim_monitoring = "${module.iam.aws_iam_role_enhanced_pinguim_monitoring}"
   aws_secretsmanager_secret_version_rdspassword = "${module.secrets.aws_secretsmanager_secret_version_rdspassword}"
   subnets_privada_id =  "${module.network.subnets_privada_id}" 

}  

 module "fargate" {
  source = "../../source/modulos/fargate"
  efs_name = "/shared"

#####################ENV
database__client = "mysql"

database__connection__user = local.database__connection__user
database__connection__password = "${module.secrets.aws_secretsmanager_secret_version_rdspassword}"
database__connection__database =  "${module.basedados.rdsproxy_endpoint}"
  aws_iam_role_ecs-autoscale-role =  "${module.iam.aws_iam_role_ecs-autoscale-role}"
  file_system_id  = "${module.criar_efs.aws_efs_file_system_efs_system_id}"
  access_point_id_id  = "${module.criar_efs.access_point_id_id}"
  sg_ec2 = "${module.SG.aws_security_group_efs}"
  container_port = "80"
  name = "pinguim"
  environment = local.environment
  aws_security_group_ecs_tasks = "${module.SG.aws_security_group_ecs_tasks}"
  pinguim_ecs_task_execution_role =  "${module.iam.pinguim_ecs_task_execution_role}" 
  subnets_privada_id =  "${module.network.subnets_privada_id}" 
  subnets_publica_id =  "${module.network.subnets_publica_id}" 
  alb_security_groups  = "${module.SG.aws_security_group_alb_id_id}"
  nometaskdefenitionsem_mont = "0"
  fazer_sg = 0
  nometaskdefenition = "sigom_net_core"
  vpc_id = "${module.network.aws_vpc_vpc_cross_id}"
  fargate_cpu = "2"
   fargate_memory = "512"
  app_image = local.app_image
  autoscaling_scale_in_cooldown = "22"
  autoscaling_scale_out_cooldown = "22"
  depends_on = [module.basedados]
}   



 module "prometheus" {
  source = "../../source/modulos/prometheus"
}   


    module "waf" {
  source = "../../source/modulos/awf"
}  



  module "cdn" {
  source = "../../source/modulos/cdn"

  aws_wafv2_web_acl_cdbpinguim_arn = "${module.waf.aws_wafv2_web_acl_cdbpinguim_arn}"

  domain_name = "ghost"
 aws_lb_main_dns_name = "${module.fargate.aws_lb_main_dns_name}"
  aws_lb_main_id = "${module.fargate.aws_lb_main_id}"
  depends_on = [module.waf]

}  


 module "lambda" {
source = "../../source/modulos/lambda"
aws_iam_lambda_role ="${module.iam.aws_iam_lambda_role}"
 }