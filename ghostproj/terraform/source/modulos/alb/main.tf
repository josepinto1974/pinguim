resource "aws_lb" "main" {
  name               = var.albnome
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.subnets_id
 
  enable_deletion_protection = false
}
 