

#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group
#enabled_metrics
#https://cwong47.gitlab.io/technology-terraform-aws-ecs-autoscale/

#health_check_type

### Compute



/* resource "aws_autoscaling_group" "asg" {
  count = length(var.subnets_privada_id)
  vpc_zone_identifier       = ["var.subnets_privada_id[count.index].id"]
  desired_capacity          = 1
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  launch_configuration      = aws_launch_configuration.pinguim.name
  
  protect_from_scale_in     = true
  termination_policies      =  ["Default"]
}




resource "aws_launch_configuration" "pinguim" {
  image_id             = "ami-019368fde4b9ba18e"
  instance_type        = "t3.micro"
  name                 = "ec2"
  iam_instance_profile  = var.iam_instance_profile
  user_data            = var.user_data 

  key_name             = var.key_name
  
  security_groups      =  [var.sg_ec2]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

    lifecycle {
    create_before_destroy = true
  }
} */



/* 
resource "aws_autoscaling_group" "web" {
  name = "${aws_launch_configuration.web.name}-asg"
  min_size             = 1
  desired_capacity     = 1
  max_size             = 1
  
  health_check_type    = "ELB"
  load_balancers = [
    "${aws_elb.web_elb.id}"
  ]
launch_configuration = "${aws_launch_configuration.web.name}"

metrics_granularity = "1Minute"
vpc_zone_identifier  = [
    "${aws_subnet.demosubnet.id}",
    "${aws_subnet.demosubnet1.id}"
  ]
# Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
tag {
    key                 = "Name"
    value               = "web"
    propagate_at_launch = true
  }
}
 */


resource "aws_instance" "ec2instance" {
    instance_type = var.instance_type
    ami =  var.ami_id 
    #iam_instance_profile = var.iamrole
    subnet_id = var.subnet_id_puba
    security_groups = toset([var.sg_ec2])
    key_name = var.key_name
    associate_public_ip_address = var.associate_public_ip_address
    user_data= var.user_data
   
    tags = {
      Name = var.ec2_name
    }
  }


