#AMI
#jenkins-agent-linux-jnlp-01-v2.1
#ami-08a73aa9ce5b8ac90


#jenkins-agent-windows-jnlp-01-v2.3
#ami-095fc69e304e5ae1f



#jenkins-master-linux-v2.1
#ami-0ad6aece3fe04efa7


####fargate inicio
variable "cdir_vpc_ldap" {
  type = string
  default = "173.25.0.0/16"
}


variable "amiwindows" {
  type = string
  default = "ami-095fc69e304e5ae1f"
}


variable "amilinux" {
  type = string
  default = "ami-08a73aa9ce5b8ac90"
}



variable "amilinux_bastian" {
  type = string
  default = "ami-08b993f76f42c3e2f"
}

##TEM
variable "amilinux_master" {
  type = string
  default = "ami-0ad6aece3fe04efa7"
}

##TEM
variable "aws_subnet_private1_aza_id" {
 
  default = ""
}




variable "nomeec2" {
  type = string
  default = "nomeec2"
}

variable "user_data" {
 
  default = ""
}

variable "aws_vpc_vpc_cross_id" {
  
  default = ""
}

##TEM
variable "ec2tipo" {
  type = string
  default = "t2.micro"
}

variable "novaamilinux" {
  type = string
  default = "ami-055575a0c2704effa"
}


variable "nome_SG_jpteste" {
  type = string
  default = "scib-cross-sg"
}


variable "bastian_linux" {
  type = string
  default = "scib-cross-ec2-bastian"
}

variable "availability_zone" {
  type = string
  default = "eu-west-2a"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "monitoring" {
  type = string
  default = "t2.micro"
}

##TEM
variable "jenkins_server_linux" {
  type = string
  default = "scib-sigom-ec2-jenkins_server"
}

variable "jenkins_slave_linux" {
  type = string
  default = "scib-cross-ec2-jenkins_slave"
}



variable "jenkins_slave_windows" {
  type = string
  default = "scib-cross-ec2-jslave_windows"
}



variable "nome_vpc_ldap" {
  type = string
  default = "scib-cross-vpc-ldap"
}

variable "routetable_name_ldap" {
  type = string
  default = "scib-cross-routetable-ldap"
}

variable "subnet_cdir_subnetpubl_aza" {
  type = string
  default = "173.25.10.0/24"
}

###Fargate fim

variable "nome_vpc" {
  type = string
  default = "scib-cross-vpc"
}


variable "subnet_nome_subnetpublica_aza" {
  type = string
  default = "subnetpublicadobastian"
}

variable "subnet_cdir_subpublica_aza" {
  type = string
  default = "10.0.11.0/24"
}


#subnetAZ publica
variable "subnet_cdir_subpublica_nat_aza" {
  type = string
  default = "10.0.31.0/24"
}

variable "subnet_cdir_subpublica_nat_azb" {
  type = string
  default = "10.0.61.0/24"
}

variable "subnet_cdir_subpublica_nat_azc" {
  type = string
  default = "10.0.91.0/24"
}


###fim subnet publica

variable "nome_ldap_vpc" {
  type = string
  default = "scib-cross-vpc-lpad"
}

variable "cdir_vpc" {
  type = string
  default = "10.0.0.0/16"
}


variable "subnet_nome_subnetpublic_aza" {
  type = string
  default = "subnetpublicaAVAZA"
}

variable "subnet_nome_subnetpunlic_azb" {
  type = string
  default = "subnetpublicaAVAZB"
}

variable "subnet_nome_subnetpublic_azc" {
  type = string
  default = "subnetpublicaAVAZC"
}

variable "cidir_da_vpc_do_ldap" {
  type = string
  default = "172.24.0.0/16"
}

variable "subnet_nome_subnetpriv_aza" {
  type = string
  default = "jpsubnetprivaza"
}

variable "subnet_cdir_subnetpriv_aza" {
  type = string
  default = "10.0.1.0/24"
}






variable "subnet_nome_subnetpriv_azb" {
  type = string
  default = "jpsubnetprivazb"
}

variable "subnet_cdir_subnetpriv_azb" {
  type = string
  default = "10.0.2.0/24"
}

variable "subnet_nome_subnetpriv_azc" {
  type = string
  default = "jpsubnetprivazc"
}

variable "subnet_cdir_subnetpriv_azc" {
  type = string
  default = "10.0.3.0/24"
}







variable "igw_name" {
  type = string
  default = "scib-cross-IGW"
}


variable "routetable_name" {
  type = string
  default = "scib-cross-routetable"
}


variable "key_par_name" {
  type = string
  default = "ec2-key"
}

#TEM
variable "iamrole_name" {
  type = string
  default = "ec2-access-to-services-role"
}

variable "publicdestCIDR" {
  type = string
  default = "0.0.0.0/0"
}


variable "ldapvpcCIDR" {
  type = string
  default = "172.24.0.0/16"
}



#####Fargatevariaveis

variable "ldap_cluster_name" {
  type = string
  default = "scib-cross-services-fargate"
}


##criar subnet_nome_subnetpriv_aza

variable "subnet_id" {
  type = string
  default = ""
}



variable "bastian_ip_privado" {
  type = string
  default = ""
}


variable "nome_SG_bastian" {
  type = string
  default = "scib-cross-services-fargate"
}