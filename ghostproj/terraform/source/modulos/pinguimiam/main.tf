#######LAmba ima


resource "aws_iam_role" "lambda_policy" {
  name = "lambda_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
   "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

  tags = {
    tag-key = "tag-value"
  }
}





resource "aws_iam_role_policy_attachment" "lambdardspinguim" {
  role = aws_iam_role.lambda_policy.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


###################RDS login to auth using iam
/* 



resource "aws_iam_role" "RDS_role" {
  name = "RDS_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
         "Action": [
             "rds-db:connect"
         ],
         "Resource": [
             "arn:aws:rds-db:us-east-2:1234567890:dbuser:db-ABCDEFGHIJKL01234/db_user"
         ]
    }
  ]
})

  tags = {
    tag-key = "tag-value"
  }
}

*/
#######################
####BEGIN IAM to RDS PROXY
##############################################

resource "aws_iam_role" "secrets_policy" {
  name = "secrets_policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})

  tags = {
    tag-key = "tag-value"
  }
}


data "aws_canonical_user_id" "current" {}


locals {
  id = data.aws_canonical_user_id.current.id
  
}


resource "aws_iam_role_policy" "secrets_policy" {
  name = "secrets_policy"
  role = aws_iam_role.secrets_policy.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "secretsmanager:GetSecretValue",
             "Resource": [
                "arn:aws:secretsmanager:us-east-3:local.id:secret:secret_name_1",
                "arn:aws:secretsmanager:us-east-3:local.id:secret:secret_name_2"
            ]  
        }
       
    ]
})
}



#######################
####END IAM to RDS PROXY
##############################################





resource "aws_iam_instance_profile" "ec2_profile" {
  name = "test_profile"
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = "ec2_profile"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}


#####
#fargate

/* resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name}-ecsTaskExecutionRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.name}-ecsTaskExecutionRole"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
} */


##begin##ECS############################################

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.app_image}-${var.environment}-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

 
/* resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
 */

##END##ECS############################################


#https://github.com/turnerlabs/terraform-ecs-fargate/blob/master/env/dev/ecs.tf
#AmazonECSTaskExecutionRolePolicy

resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole_policy" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}




#####

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.0.0"
    }
  }
}

provider "aws" {
  region = "eu-west-3"
}




/* resource "aws_iam_role" "pinguim_cloudagent" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
 */



resource "aws_iam_instance_profile" "iam_instance_profile_cloudwatch" {
  name = "iam_instance_profile_cloudwatch"
  role = aws_iam_role.pinguim_cloudagent_role.name
}




resource "aws_iam_role" "pinguim_cloudagent_role" {
  name = "pinguim_cloudagent_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}



resource "aws_iam_role_policy_attachment" "role-policy-attachment" {
  
  role       = "${aws_iam_role.pinguim_cloudagent_role.name}"
  for_each = toset([
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy", 
    "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  ])

 
  policy_arn = each.value
}


####################################################################################
####ECS autoscaling iam
###################################################################################

resource "aws_iam_role" "ecs-autoscale-role" {
  name = "ecs-scale-application"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "application-autoscaling.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs-autoscale" {
  role = aws_iam_role.ecs-autoscale-role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}







###########################################################################
#############################################################################


/* # terraform providers
data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

 resource "aws_iam_role" "pinguim" {
  name                = "yak_role"
  assume_role_policy  = data.aws_iam_policy_document.instance-assume-role-policy.json # (not shown)
  managed_policy_arns = [aws_iam_policy.policy_one.arn, aws_iam_policy.policy_two.arn]
} 

resource "aws_iam_policy" "policy_one" {
  name = "policy-618033"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
       "Effect": "Allow",
            "Action": [
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:Describe*",
                "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
                "elasticloadbalancing:DeregisterTargets",
                "elasticloadbalancing:Describe*",
                "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
                "elasticloadbalancing:RegisterTargets"
            ],
            "Resource": "*"
      },
    ]
  })
}

resource "aws_iam_policy" "policy_two" {
  name = "policy-381966"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:ListAllMyBuckets", "s3:ListBucket", "s3:HeadBucket"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


#####



resource "aws_iam_role" "pinguim_proxy_role" {
  name = "pinguim_proxy_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
     "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "arn:aws:secretsmanager:us-west-2:111122223333:secret:*"
        },
        {
            "Effect": "Allow",
            "Action": "secretsmanager:ListSecrets",
            "Resource": "*"
        }
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}
 */


##begin##monitoramento avançado###########################################

# https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
/* resource "aws_iam_role" "ecsTaskExecutionRole" {
  name               = "${var.app_image}-${var.environment}-ecs"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

 
resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
 */

##END##ECS############################################

# create IAM role for monitoring
resource "aws_iam_role" "enhanced_pinguim_monitoring" {
  name               = "rds-cluster-example-1"
  assume_role_policy = data.aws_iam_policy_document.enhanced_pinguim_monitoring.json
}

# Attach Amazon's managed policy for RDS enhanced monitoring
resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role = aws_iam_role.enhanced_pinguim_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# allow rds to assume this role
data "aws_iam_policy_document" "enhanced_pinguim_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}





#########################
###lambda
/* 
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]
}
 */

################################################




resource "aws_iam_role" "lambda-role" {
  name = "lambda-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role = aws_iam_role.lambda-role.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}
