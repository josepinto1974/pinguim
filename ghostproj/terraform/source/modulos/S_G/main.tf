#SG para aws_ecs_cluster
resource "aws_security_group" "ecs_tasks" {
  
  name   = "SG_FARGATE"
   #vpc_id =  chomp(file("aws_vpc_vpc_cross_id"))
   vpc_id = var.vpcid

  ingress {
   protocol         = "tcp"
   from_port        = "0"
   to_port          = "65535"
   cidr_blocks      = [var.cidr_blocks]
   
   
  }
 

   

     ingress {
   protocol         = "tcp"
   from_port        = "80"
   to_port          = "8000"
   cidr_blocks      = [var.cidr_blocks]
   
   
  }

  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   
  }
}



resource "aws_security_group" "alb" {
  name   = "${var.name}-sg-alb-${var.environment}"
  vpc_id = var.vpcid
 
  ingress {
   protocol         = "tcp"
   from_port        = 80
   to_port          = 80
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  ingress {
   protocol         = "tcp"
   from_port        = 443
   to_port          = 443
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
}


/* resource "aws_security_group" "ecs_tasks" {
  name   = "${var.name}-sg-task-${var.environment}"
  vpc_id = var.vpc_id
 
  ingress {
   protocol         = "tcp"
   from_port        = var.container_port
   to_port          = var.container_port
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
 
  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   ipv6_cidr_blocks = ["::/0"]
  }
} */


resource "aws_security_group" "efs" {
  name   = "SG_ECS_LDAP"
   vpc_id = var.vpcid
 

  ingress {
   protocol         = "tcp"
   from_port        = "80"
   to_port          = "80"
   cidr_blocks      = ["0.0.0.0/0"]
   
   
  }
 

   ingress {
   protocol         = "0"
   from_port        = "0"
   to_port          = "0"
   cidr_blocks      = ["173.25.0.0/16"]
   
   
  }

     ingress {
   protocol         = "tcp"
   from_port        = "0"
   to_port          = "0"
   cidr_blocks      = ["10.0.0.0/16"]
   
   
  }

  egress {
   protocol         = "-1"
   from_port        = 0
   to_port          = 0
   cidr_blocks      = ["0.0.0.0/0"]
   
  }
}


#################
#RDS
#################

resource "aws_security_group" "rds" {
  name        = "terraform_rds_security_group"
  description = "Terraform example RDS MySQL server"
  vpc_id      = var.vpcid
  # Keep the instance private by only allowing traffic from the web server.
 /*  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.default.id}"]
  } */

 ingress {
   protocol         = "tcp"
   from_port        = "0"
   to_port          = "0"
   cidr_blocks      = ["${var.cidr_blocks}"]
   
   
  }

 ingress {
   protocol         = "-1"
   from_port        = "0"
   to_port          = "0"
   cidr_blocks      = ["10.0.0.0/16"]
   
   
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
   /* tags = {
    Name = var.nome_SG_jpteste
    CIA =var.CIA_value
    billing = var.billing

  } */
}