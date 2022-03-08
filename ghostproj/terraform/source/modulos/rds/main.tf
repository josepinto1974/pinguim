locals {
  regiao = "eu-west-3"
  
}

 locals {
  regiaoDC = "eu-west-3"
  
}

locals {
  AZregiaoDC = "eu-west-3a"
  
}




/*  resource "aws_db_subnet_group" "default" {
  name       = "my_database_subnet_group"
  subnet_ids = [var.subnet1,var.subnet2]

  tags = {
    Name = "My DB subnet group"
  }
} 
 */

##################################

/* resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
} */


#######################################





########################################

/* variable "rds_var" {
  type = map(object({
    availability_zone = string
  }))
  default = {
    "rdsa" = {
      
      availability_zone = "eu-west-3a"
    }
    
  }
} */

variable "rds_var" {
  type = map(object({
    availability_zone = string
  }))
  default = {
    "rdsa" = {
      
      availability_zone = "eu-west-3a"
    }
    "rdsb" = {
      
      availability_zone = "eu-west-3b"
    }
    "rdsc" = {
      
      availability_zone = "eu-west-3c"
    }
  
  }
}



#####d
#multi_az = true and availability_zone are not compatible

resource "aws_db_instance" "nova" {
  #for_each                = var.rds_var
  monitoring_role_arn =  var.aws_iam_role_enhanced_pinguim_monitoring
  allocated_storage    = var.initialstoradge
  identifier                = "pinguim"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  db_name                      = "pinguim"
  username                  = var.database__connection__user
  password                  = var.aws_secretsmanager_secret_version_rdspassword
  db_subnet_group_name      = "${var.aws_db_subnet_group_private}"
  vpc_security_group_ids    =  ["${var.SG_RDS}"]
  max_allocated_storage     = var.maxstrore
  skip_final_snapshot  = true
  enabled_cloudwatch_logs_exports = toset(["audit","error", "general"])
  multi_az = true
  #availability_zone       = each.value.availability_zone
  #availability_zone       = var.rds_var
  iam_database_authentication_enabled = true
  monitoring_interval = 10
  publicly_accessible = false
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true
  tags = {
    Name = "pinguimrds"
  }
  depends_on = [aws_db_proxy.pinguim]
}

#subnets_cross_id1
####################################################################
####inicio rds proxy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_target
##################################################################

#subnets_cross_idall

#REVER1 secret_arn


locals {
  aws_db_proxy_pinguim_name  = "pinguim2"
  
}

resource "aws_db_proxy" "pinguim" {
  #count = length(var.subnets_privada_id)
  vpc_subnet_ids       = [var.subnets_privada_id[0], var.subnets_privada_id[1]]

  name                   = local.aws_db_proxy_pinguim_name
  debug_logging          = false
  engine_family          = "MYSQL"
  idle_client_timeout    = 1800
  require_tls            = false
  role_arn               = var.pinguim_proxy_role
  vpc_security_group_ids = ["${var.SG_RDS}"]
  #vpc_subnet_ids         = ["var.aws_db_subnet_group_private"]

  auth {
    auth_scheme = "SECRETS"
    description = "example"
    iam_auth    = "DISABLED"
    secret_arn  = var.aws_secretsmanager_secret_version_rdspassword
  }

  
}

resource "aws_db_proxy_default_target_group" "pinguim" {
  #count = length(var.subnets_privada_id)
  db_proxy_name = local.aws_db_proxy_pinguim_name

  connection_pool_config {
    connection_borrow_timeout    = 120
    init_query                   = "SET x=1, y=2"
    max_connections_percent      = 100
    max_idle_connections_percent = 50
    session_pinning_filters      = ["EXCLUDE_VARIABLE_SETS"]
  }
}

resource "aws_db_proxy_target" "example" {
  db_instance_identifier = aws_db_instance.nova.id
  db_proxy_name          = local.aws_db_proxy_pinguim_name
  target_group_name      = aws_db_proxy_default_target_group.pinguim.name
}


####################################################################
####FIM rds proxy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_proxy_target
##################################################################





/* 
resource "aws_cloudwatch_log_group" "error" {
  name = "/aws/rds/instance/${aws_db_instance.prod.identifier}/error"
  retention_in_days = "3"
}

resource "aws_cloudwatch_log_group" "audit" {
  name = "/aws/rds/instance/${aws_db_instance.prod.identifier}/audit"
  retention_in_days = "3"
}

resource "aws_cloudwatch_log_group" "general" {
  name = "/aws/rds/instance/${aws_db_instance.prod.identifier}/genral"
  retention_in_days = "3"
} */
#final_snapshot_identifier

/* data "aws_db_snapshot" "latest_prod_snapshot" {
  db_instance_identifier = aws_db_instance.prod.id
  most_recent            = true
} */

# Use the latest production snapshot to create a dev instance.
/*resource "aws_db_instance" "dev" {
  instance_class      = "db.m5.large"
  name                = "mydbdev"
  snapshot_identifier = "cib-cross-services-oracledb-sigom-core46"

  lifecycle {
    ignore_changes = [snapshot_identifier]
  }
}  */





################





/*  resource "aws_db_subnet_group" "default" {
  name       = "my_database_subnet_group"
  subnet_ids = [var.subnet1,var.subnet2]

  tags = {
    Name = "My DB subnet group"
  }
} 
 */

##################################

/* resource "aws_db_parameter_group" "default" {
  name   = "rds-pg"
  family = "mysql5.6"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
} */


#######################################


