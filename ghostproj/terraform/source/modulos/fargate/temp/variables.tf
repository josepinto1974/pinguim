variable "fargate_cpu" {
  type = string
  default = "173.25.0.0/16"
}


variable "fargate_memory" {
  type = string
  default = "173.25.0.0/16"
}


variable "app_image" {
  type = string
  default = "173.25.0.0/16"
}

variable "container_port" {
  type = string
  default = "80"
}

variable "cluster_name" {
  type = string
  default = "80"
}

variable "enable_autoscaling" {
  type = string
  default = "1"
}


variable "ecr_repo" {
  type = string
  default = "1"
}

variable "app_version" {
  type = string
  default = "1"
}






