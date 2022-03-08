locals {
  regiao = "eu-west-3"
  
}

 locals {
  regiaoDC = "eu-west-3"
  
}

locals {
  AZregiaoDC = "eu-west-3a"
  
}


resource "aws_cloudwatch_log_group" "aws_ecs_cluster" {
  name = "aws_ecs_cluster"
}


resource "aws_ecs_cluster" "main" {
  #name = "${var.name}-cluster-${var.environment}"
  name = "pinguim_ecs_ghost"

setting {
       name = "containerInsights"
       value = "enabled"

     }
  configuration {
    execute_command_configuration {
      #kms_key_id = aws_kms_key.example.arn
      logging    = "OVERRIDE"

     
      log_configuration {
        cloud_watch_encryption_enabled = true
        cloud_watch_log_group_name     = aws_cloudwatch_log_group.aws_ecs_cluster.name
      }
    }
  }
}
#adicionar logs

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster





#https://github.com/terraform-aws-modules/terraform-aws-vpc/issues/395  bom
#https://stackoverflow.com/questions/66002836/how-to-use-for-each-inside-the-subnet-mapping-in-terraform-so-i-can-map-the
#### slavar:  C:\documentos\empregos\pinguim\BCK_antes_mudar_fargate
#https://engineering.finleap.com/posts/2020-02-20-ecs-fargate-terraform/
 
 
  
 
 resource "aws_s3_bucket" "aws_lb" {
  bucket = "aws_lbpinguim"
  
  
}
 
 resource "aws_lb" "main" {
  name               = "${var.name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb_security_groups}"]
   subnets     = var.subnets_publica_id[*]
  #subnets     = [var.subnets_publica_id[0] , var.subnets_publica_id[1]]
  #subnets             = sort([for s in var.subnets_publica_id: {
                  #   s = tolist(s.ids.key) }])
  enable_waf_fail_open = true
  enable_cross_zone_load_balancing = true

  enable_deletion_protection = false

     access_logs {
    bucket  = resource.aws_s3_bucket.aws_lb.arn
    prefix  = "alb"
    enabled = true
  }

}
 




/* resource "aws_lb" "main" {
  for_each                = toset(var.subnets_publica_id)
  name               = "${var.name}-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb_security_groups}"]
  subnets     = [each.value.id ]
  #subnets             = sort([for s in var.subnets_publica_id: {
                  #   s = tolist(s.ids.key) }])
   
  

  enable_deletion_protection = false
}
 */




 
 resource "aws_alb_target_group" "main" {
  
  name        = "${var.name}-tg-${var.environment}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "3"
   path                = "/index.html"
   unhealthy_threshold = "2"
  }
  depends_on = ["aws_lb.main"]
}

/*  resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.main.id
  port              = 80
  protocol          = "HTTP"
 
  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
 
   redirect {
     port        = 443
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
  
 
}  
 */


resource "aws_alb_listener" "http" {  
  load_balancer_arn = aws_lb.main.arn
  port              = "80"  
  protocol          = "HTTP"
  
  default_action {    
    target_group_arn = "${aws_alb_target_group.main.arn}"
    type             = "forward"  
  }
}
/*  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate
  
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.main.id
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb_tls_cert_arn
 
  default_action {
    target_group_arn = aws_alb_target_group.main.id
    type             = "forward"
  }
}
 */

####ok


/* resource "aws_ecs_task_definition" "pinguim" {
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  family = "pinguim_task_definition"
  cpu                      = 256
  memory                   = 512
  #execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  #task_role_arn            = aws_iam_role.ecs_task_role.arn
  container_definitions = jsonencode([{
   name        = "${var.name}-container-${var.environment}"
   image       = "${var.app_image}:latest"
   essential   = true
   "environment": [
      {"name": "VARNAME", "value": "VARVAL"}
    ],
   portMappings = [{
     protocol      = "tcp"
     containerPort = "80"
     hostPort      = "80"
   }]
}])
} */


####
#EFS para LDAP
#####

/* module "criar_efs" {
  source = "../../source/modulos/efs"
  efs_name = var.efsldap
  subnet_a = "1"
  efstags = "projsigom"
  CIA_value = "CLL"
billing = "crossdev"
subnet_id = "${module.redes.aws_subnet_publica_aza_id}"
 sg_efs2 = "${module.SG.aws_security_group__efs_1_id}"
access_point = "/config"
vpc_id = "${module.redes.aws_vpc_vpc_cross_id}"
}
 */

########################
#EFS para o servico EMS
#######################

/* module "criar_efs_ems" {
  source = "../../source/modulos/efs"
  efs_name = "/shared"
  subnet_a = "1"
  efstags = "ems"
  CIA_value = "CLL"
billing = "crossdev"
subnet_id = "${module.redes.aws_subnet_publica_aza_id}"
 sg_efs2 = "${module.SG.aws_security_group__efs_1_id}"
access_point = "/shared"
vpc_id = "${module.redes.aws_vpc_vpc_cross_id}"
} */
#werro aqui  access_point = "/ems"






variable "app_environments_vars" {
type        = list(map(string))

description = "environment varibale needed by the application"
default = [
{
  "name" = "database__client",
  "value" = "/config/ldap_users.csv"
},{
  "name" = "database__connection__host",
  "value" = "0.0.0.0"
},{
  "name" = "database__connection__user",
  "value" = "1"
},{
  "name" = "database__connection__password",
  "value" = "3890"
},{
  "name" = "database__connection__database",
  "value" = "/config/LOCAL_CONFIG.json"
}]

}
###################################



######################################

resource "aws_ecs_task_definition" "pinguim" {
  #count = "${var.nometaskdefenitionsem_mont ? 1 : 0}"
  family                   = "ecsghostpinguim"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  task_role_arn            = var.pinguim_ecs_task_execution_role
  execution_role_arn       =  var.pinguim_ecs_task_execution_role



  container_definitions = <<DEFINITION
 [
      {
	      "cpu": ${var.fargate_cpu},
        "memory": ${var.fargate_memory},
        "name": "${var.app_image}",
        "image": "${var.app_image}",
        "essential": true,
        "environment": ${jsonencode(var.app_environments_vars)},
        volume {
            name = "sigomconfigefs"

         efs_volume_configuration {
             file_system_id          = "${var.file_system_id}",
             root_directory          = "${var.efs_name}",
             transit_encryption      = "ENABLED"
             transit_encryption_port = 2999
             authorization_config {
                access_point_id = var.access_point_id_id
                iam  = "ENABLED"
             }  
          }
}

         "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-region" : "${local.regiaoDC}",
                    "awslogs-group" : "/fargate/service/${var.name}-${var.environment}",
                    "awslogs-stream-prefix" : "ecs"
                }
            },
         "mountPoints": [
          {
            "sourceVolume": "sigomconfigefs",
            "containerPath": "/config",
            "readOnly": false
          }
        ],    
         "portMappings": [
      { 
        

        "containerPort": 2368,
        "protocol": "tcp"
      }

    ]
      }
]
DEFINITION

}

 



resource "aws_ecs_service" "main" {
 name                               = "${var.app_image}"
 cluster                            = aws_ecs_cluster.main.id
 task_definition                    = aws_ecs_task_definition.pinguim.arn
 desired_count                      = 2
 deployment_minimum_healthy_percent = 50
 deployment_maximum_percent         = 200
 launch_type                        = "FARGATE"
 scheduling_strategy                = "REPLICA"
 
 network_configuration {
   security_groups  = toset([var.aws_security_group_ecs_tasks])
   subnets          = ["${var.subnets_privada_id[0]}" , "${var.subnets_privada_id[1]}"]
   assign_public_ip = false
 }
 
 load_balancer {
   target_group_arn = aws_alb_target_group.main.arn
   container_name   = "${var.app_image}"
   container_port   = 2368
 }
 
 lifecycle {
   ignore_changes = [task_definition, desired_count]
 }
 
 depends_on = ["aws_alb_listener.http"]
}

#depends_on = ["aws_alb_target_group.main"]



resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 4
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.main.name}/${aws_ecs_service.main.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
  role_arn   = var.aws_iam_role_ecs-autoscale-role
}





#scaling based in MEMORY

resource "aws_appautoscaling_policy" "ecs_policy_memory" {
  name               = "memory-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
    disable_scale_in   = false
    scale_in_cooldown  = var.autoscaling_scale_in_cooldown
    scale_out_cooldown = var.autoscaling_scale_out_cooldown
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageMemoryUtilization"
   }
 
   target_value       = 80
  }
}
 

 #scaling based in CPU
/* resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
  name               = "cpu-autoscaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace
 
  target_tracking_scaling_policy_configuration {
    disable_scale_in   = false
    scale_in_cooldown  = var.autoscaling_scale_in_cooldown
    scale_out_cooldown = var.autoscaling_scale_out_cooldown
   predefined_metric_specification {
     predefined_metric_type = "ECSServiceAverageCPUUtilization"
   }
 
   target_value       = 80
  }
}
 */
