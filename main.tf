#originalcuidados#Projecto principal ccross
#region = "us-west-2"

locals {
  regiao = "eu-west-3"
  
}

 locals {
  regiaoDC = "eu-west-3"
  
}

locals {
  AZregiaoDC = "eu-west-3a"
  
}


terraform {
   backend "s3" {
    bucket = "terraformtfstatejp"
    key    = "terraform-testeestudo.tfstate"
    region = "eu-west-3"
   
  }
}

provider "aws" {
  profile    = ""
  region     = local.regiao
 
}

######criacao do file de task defenition aqui porque devido ao problema o fargate é criado dentro de network


variable "pub_subnet" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
  }))
  default = {
    "PubSub1" = {
      cidr_block        = "172.16.1.0/24"
      availability_zone = "eu-west-3a"
    }
    "PubSub2" = {
      cidr_block        = "172.16.13.0/24"
      availability_zone = "eu-west-3b"
    }
  
  }
}




module "network" {
  source = "../network"
   pub_subnet = var.pub_subnet
  regiaoDC     = local.regiao
  AZregiaoDC = local.AZregiaoDC
  cdir_vpc = var.cdir_vpc
  ##subnet_cdir_subnetpriv_aza = var.subnet_cdir_subnetpriv_aza
  #subnet_nome_subnetpriv_aza = "awslab-subnet-private"
  subnet_cdir_subpublica_nat_aza  = "172.26.0.0/27"
  subnet_cdir_subnetpriv_aza = "172.26.0.32/27"
  subnet_cdir_subpublica_nat_azb = "172.26.0.64/27"
  nome_vpc = "awslab-vpc"
  #routetable_name = "awslab-rt-internet"
  igw_name="cocus_IGW"
  ###LDAP_VPC
 map_public_ip_on_launch_priv = false
 map_public_ip_on_launch_pub = true

  subnet_nome_subnetpublic_aza = "awslab-subnet-public"
  subnet_nome_subnetpriv_aza   = "awslab-subnet-private"
 
}


###SG

module "SG" {
  source = "../SG"
   aws_vpc_vpc_cross_id = "${module.network.aws_vpc_vpc_cross_id}"
   
   vpc_ldap_id_p = "${module.network.aws_vpc_vpc_cross_id}"
  
cdir_vpc= var.cdir_vpc


nome_SG_ec2 = "SG_EC2_EFS"


} 



###public Ec2


data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
owners = ["099720109477"]
    
}

  


/*
  module "basedados" {
  source = "../rds"
  SG_RDS = "${module.SG.aws_security_group__rds}"
   subnet1 = "subnet-0f80f34037924b5f6"
 subnet2 = "subnet-0db051ced5153b534"
    snapshot = "cib-cross-services-oracledb-sigom-core46"
    vpc_ldap_id_p = "${module.network.aws_vpc_vpc_cross_id}"
   
}    

*/