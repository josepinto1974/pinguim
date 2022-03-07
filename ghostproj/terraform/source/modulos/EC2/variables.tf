####
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "iamrole" {
  type = string
  default = "t2.micro"
}



variable "key_par_name" {
  type = string
  default = "finatakp"
}
variable "sg_ec2" {
  type = string
  default = "L00mmmmm00LL"
}
variable "subnet_id_puba" {
  type = string
  default = "10.0.11.0/24"
}



variable "iam_instance_profile" {
  type = string
  default = "10.0.11.0/24"
}

variable "subnets_privada_id" {
  type = list
  default = ["000"]
}

variable "associate_public_ip_address" {
  type = string
  default = "false"
}


variable "subnet_cdir_subpublica_nat_aza" {
  type = string
  default = "10.0.31.0/24"
}

variable "nome_vpc" {
  type = string
  default = "scib-cross-vpc"
}


variable "aws_vpc_vpc_cross_id" {
  type = string
  default = ""
}

variable "aws_subnet_private1_aza_id" {
  type = string
  default = "ec2-access-to-services-role"
}

variable "ec2_name" {
  type = string
  default = "ec2nome"
}

variable "map_public_ip_on_launch_var" {
  type = string
  default = "ec2nome"
}

variable "user_data" {
  type = string
  default = "scib-cross-services-fargate"
}

variable "ami_id" {
  type = string
  default = "ami-0d3c032f5934e1b41"
}
variable "subnet_id" {
  type = string
  default = ""
}

 variable "security_groups" {
  type = string
  default = "SSS"
} 

variable "key_name" {
  type = string
  default = "key"
}