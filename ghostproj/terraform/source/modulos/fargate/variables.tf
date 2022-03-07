variable "fargate_cpu" {
  type = string
  default = ""
}



variable "vpc_ldap_id_p" {
  type = string
  default = ""
}

variable "subnet_ID" {
  type = string
  default = ""
}

variable "container_port" {
  type = string
  default = "80"
}

variable "name" {
  type = string
  default = "ec2nome"
}

variable "environment" {
  type = string
  default = "ec2nome"
}


variable "sem_mont" {
  type = string
  default = ""
}

variable "lista_subids1" {
  type = string
  default = "ec2nome"
}

/* variable "subnets_privada_id" {
  type = list
  default = ["000"]
} */
variable "efs_name" {
  type = string
  default = "iam_role_name"
}

variable "subnets_privada_id" {
  type = list
  default = ["000"]
}

variable "file_system_id" {
  type = string
  default = "iam_role_name"
}

variable "aws_iam_role_ecs-autoscale-role" {
  type = string
  default = "aws_iam_role_ecs-autoscale-role"
}

variable "subnets_publica_id" {
  type = list
  default = ["pppp"]

}


variable "autoscaling_scale_in_cooldown" {
  type = string
  default = "wwwt2.micro"
}



variable "autoscaling_scale_out_cooldown" {
  type = string
  default = "wwwt2.micro"
}

variable "sg_ec2" {
  type = string
  default = "L00mmmmm00LL"
}


variable "com_mont" {
  type = string
  default = ""
}

variable "SG_1" {
  type = string
  default = ""
}


variable "fazer_sg" {
  type = string
  default = ""
}

variable "subnets" {
  type = string
  default = ""
}

variable "pinguim_ecs_task_execution_role" {
  type = string
  default = ""
}


variable "aws_security_group_ecs_tasks" {
  type = string
  default = "ec2nome"
}


variable "fargate_memory" {
  type = string
  default = ""
}
variable "alb_security_groups" {
  type = string
  default = "ec2nome"
}


variable "access_point_id_id" {
  type = string
  default = "iam_role_name"
}


variable "vpc_id" {
  type = string
  default = "ec2nome"
}


variable "app_image" {
  type = string
  default = ""
}


variable "cluster_name" {
  type = string
  default = "80"
}


variable "subnet_id" {
  type = string
  default = "80"
}



variable "EFS_ID" {
  type = string
  default = ""
}

variable "nometaskdefenition" {
  type = string
  default = "80"
}


variable "nometaskdefenitionsem_mont" {
  type = string
  default = ""
}



variable "nometaskdefenitioncom_mont" {
  type = string
  default = ""
}

variable "com_mount" {
  type = string
  default = "1389"
}

variable "sem_mount" {
  type = string
  default = "1"
}



