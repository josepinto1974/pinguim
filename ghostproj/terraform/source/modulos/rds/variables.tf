
variable "subnet1" {
  type = string
  default = "wwwt2.micro"
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

variable "SG_RDS" {
  type = string
  default = "ec255555nome"
}


 variable "vpc_ldap_id_p" {
  type = string
  default = ""
}

variable "aws_db_subnet_group_private" {
  type = string
  default = "wwrwt2.micro"
}

/* variable "rds_var" {
  type = map(object({
 
    availability_zone = string
  }))
  
} */

/* variable "availabilityzone" {
  type = map(object({
 
    availability_zone = string
  }))
  
} */

 variable "subnets_privada_id" {
  type = list
  default = ["000"]
}

/* variable "rds_var" {
  type = map(object({
    availability_zone        = string
   
  }))
  
} */


 variable "availabilityzone" {
  type = string
  default = "eee"
}

 variable "maxstrore" {
  type = string
  default = ""
}

 variable "initialstoradge" {
  type = string
  default = ""
}


variable "aws_iam_role_enhanced_pinguim_monitoring" {
  type = string
  default = "ec2no888888me"
}

variable "aws_secretsmanager_secret_version_rdspassword" {
  type = string
  default = "wwwt2.micro"
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
  default = "ec2noffffffme"
}


variable "rdsproxysecret" {
  type = string
  default = "ec2nome"
}