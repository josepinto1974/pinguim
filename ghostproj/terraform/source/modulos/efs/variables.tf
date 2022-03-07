variable "efs_name" {
  type = string
  default = "efs_sigom"
}


variable "efstags" {
  type = string
  default = "efssigom"
}

/* variable "subnet_ID" {
  type = string
  default = "efssigom"
} */

variable "subnet_a" {
  type = string
  default = "ami-08a73aa9ce5b8ac90"
}

variable "vpc_ldap_id_p" {
  type = string
  default = ""
}


variable "iam_instance_profile" {
  type = string
  default = "iam_role_name"
}


/* variable "subnets_privada_id" {
  type = list(string)
}
 */

 variable "subnets_privada_id" {
  type = list
  default = ["000"]
}

variable "key_name" {
  type = string
  default = "ec2nome"
}

variable "sg_efs2" {
  type = string
  default = "ec2nome"
}

variable "access_point" {
  type = string
  default = ""
}

variable "sg_ec2" {
  type = string
  default = "L00mmmmm00LL"
}