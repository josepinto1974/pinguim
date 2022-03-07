terraform {
   backend "s3" {
    bucket = "scib-sigom-terraform"
    key    = "terraform-teste-fp_fargate.tfstate"
    region = "eu-west-2"
    profile = "cross"
  }
}




provider "aws" {
  profile    = "cross"
  region     = "eu-west-2"
  assume_role {
    role_arn = "arn:aws:iam::920768381054:role/SysOps"
  }
}


data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "scib-sigom-terraform"
    key    = "terraform-teste-fp_redes.tfstate"
    region = "eu-west-2"
    profile    = "cross"
  }
  
}




###criar file com task defenition
/* 
resource "local_file" "criar_service_definition_json" {
    count = var.enable_autoscaling ? 1 : 0
    content     = <<EOF
[
      {
	    "cpu": "${var.fargate_cpu}",
        "memory": "${var.fargate_memory}",
        "name": "jenkins-agent",
        "image": "${var.ecr_repo}:${var.app_version}",
        "essential": true,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/jenkins-agent",
            "awslogs-region": "us-west-1",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "mountPoints": [
          {
            "sourceVolume": "efs_temp",
            "containerPath": "/efs",
            "readOnly": false
          }
        ]
      }
    ]
EOF
    filename = "service.json"
}
 */


/* resource "local_file" "criar_service_definition_json" {
    count = var.enable_autoscaling ? 1 : 0
    content     = <<EOF
[
      {
	    "cpu": "${var.fargate_cpu}",
        "memory": "${var.fargate_memory}",
        "name": "jenkins-agent",
        "image": "${var.ecr_repo}:${var.app_version}",
        "essential": true,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/jenkins-agent",
            "awslogs-region": "us-west-1",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "mountPoints": [
          {
            "sourceVolume": "efs_temp",
            "containerPath": "/efs",
            "readOnly": false
          }
        ]
      }
    ]
EOF
    filename = "service.json"
}
 */

  resource "local_file" "criar_service_definition_json" {
    count = var.enable_autoscaling ? 1 : 0
    content     = <<EOF
[
      {
	    "cpu": "${var.fargate_cpu}",
        "memory": "${var.fargate_memory}",
        "name": "jenkins-agent",
        "image": "${var.ecr_repo}:${var.app_version}",
        "essential": true,
        "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/jenkins-agent",
            "awslogs-region": "us-west-1",
            "awslogs-stream-prefix": "ecs"
          }
        },
        "mountPoints": [
          {
            "sourceVolume": "efs_temp",
            "containerPath": "/efs",
            "readOnly": false
          }
        ]
      }
    ]
EOF
    filename = "service.json"
}
 