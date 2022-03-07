#EC2 to EFA

###EC2 para efs aqui vou usar um file com user data
####user data comentado so para efeitos de comparacao, não +e permitido usar user_data,
### no modulo  resource "local_file" "dadossubnet" é criaod um file com todo o conteudo do user data


resource "aws_autoscaling_group" "asg" {
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

#####LIXO




resource "aws_launch_configuration" "pinguim" {
  image_id             = "ami-019368fde4b9ba18e"
  instance_type        = "t3.micro"
  name                 = "ec2"
  iam_instance_profile  = var.iam_instance_profile
  

  key_name             = var.key_name
  
  security_groups      =  [var.sg_ec2]

  root_block_device {
    volume_size = 30
    volume_type = "gp2"
  }

    lifecycle {
    create_before_destroy = true
  }

   user_data = <<-EOF
 #!/bin/bash
 # sudo systemctl restart jenkins
              #!/bin/bash

              
              mkdir /ems
                 touch /configldap/config/ldap_users.csv 
                sleep 90s
                
                chmod 777 /configldap/config/ 
                 touch /configldap/config/ldap_users.csv 
                 touch /configldap/config/LOCAL_CONFIG.json
                 echo "antes do mont montfeito"
                 ls -l /configldap/config/
              mount -t efs -o iam,tls "${aws_efs_file_system.efs_system.id}":/ /configldap
              ls -l /configldap/
              ls -l /configldap/config/
                chmod 777 /ems
                echo $efs_id:/ /ems efs defaults,_netdev 0 0 >> /etc/fstab
               echo "ANTESTERMINAR"
               mkdir -p /configldap/config/
               echo "conf1"
               ls -l /configldap/config/
                 touch /configldap/config/ldap_users.csv 
                 touch /configldap/config/LOCAL_CONFIG.json
                 echo "FINAL"
               ls -l /configldap/config/
			   
			   echo "inicioEMS"
			   
			     #### efs TO ems ######
              mkdir -p  /shared
                 ls /shared
                sleep 90s
                chmod 777 /shared
              mount -t efs -o iam,tls "${aws_efs_file_system.efs_system.id}":/ /shared  
               chmod 777 /shared
                  
                 
                 echo "antes do mont montfeito"
                 ls -l /shared/ems
            
echo $EFS_ID_ems >> /shared/ems/auto.dat
echo $EFS_ID_ems:/ /ems efs defaults,_netdev 0 0 >> /etc/fstab
               echo "ANTESTERMINAR"
               
               #### efs TO ems ######

			   
			   echo "FIM EMSMONT
			   
			   
            
              EOF 
}



/* 
 module "instancias_efs" {
  source = "../ec2"
  AZregiaoDC     = local.AZregiaoDC
  #amilinux_master = "ami-0ab1a741b29a4ed88"
   subnets_privada_id = var.subnets_privada_id
  ami_id = "ami-0a614bb6ddb883be6"
  instance_type = "t2.micro"
  key_par_name = var.key_par_name
  subnet_cdir_subpublica_nat_aza  = "172.25.0.32/28"
  nome_vpc ="sigom"
  sg_ec2 = "${module.SG.aws_security_group__ecs2_1_id}"
  aws_vpc_vpc_cross_id = "${module.redes.aws_vpc_vpc_cross_id}"
aws_subnet_private1_aza_id="${module.redes.aws_subnet_private1_aza_id}"
  ec2_name = "ec2_efs"
 subnet_id_puba = "${module.redes.aws_subnet_private1_aza_id}"
  
   user_data = <<-EOF
 #!/bin/bash
 # sudo systemctl restart jenkins
              #!/bin/bash

              
              mkdir /ems
                 touch /configldap/config/ldap_users.csv 
                sleep 90s
                
                chmod 777 /configldap/config/ 
                 touch /configldap/config/ldap_users.csv 
                 touch /configldap/config/LOCAL_CONFIG.json
                 echo "antes do mont montfeito"
                 ls -l /configldap/config/
              mount -t efs -o iam,tls "${module.criar_efs.aws_efs_file_system_efs_system_id}":/ /configldap
              ls -l /configldap/
              ls -l /configldap/config/
                chmod 777 /ems
                echo $efs_id:/ /ems efs defaults,_netdev 0 0 >> /etc/fstab
               echo "ANTESTERMINAR"
               mkdir -p /configldap/config/
               echo "conf1"
               ls -l /configldap/config/
                 touch /configldap/config/ldap_users.csv 
                 touch /configldap/config/LOCAL_CONFIG.json
                 echo "FINAL"
               ls -l /configldap/config/
			   
			   echo "inicioEMS"
			   
			     #### efs TO ems ######
              mkdir -p  /shared
                 ls /shared
                sleep 90s
                chmod 777 /shared
              mount -t efs -o iam,tls "${module.criar_efs_ems.aws_efs_file_system_efs_system_id}":/ /shared  
               chmod 777 /shared
                  
                 
                 echo "antes do mont montfeito"
                 ls -l /shared/ems
            
echo $EFS_ID_ems >> /shared/ems/auto.dat
echo $EFS_ID_ems:/ /ems efs defaults,_netdev 0 0 >> /etc/fstab
               echo "ANTESTERMINAR"
               
               #### efs TO ems ######

			   
			   echo "FIM EMSMONT"
			   
			   
            
              EOF
}

 */


 resource "aws_efs_access_point" "pinguim" {
  file_system_id = aws_efs_file_system.efs_system.id
   
   posix_user {
   gid      = 5000
   uid      = 5000

   }
   
   
  root_directory  {
   path = var.access_point

   creation_info {
   owner_uid      = 5000
   owner_gid      = 5000
   permissions    = 1777
      }
  }
} 






resource "aws_efs_file_system" "efs_system" {
  creation_token = var.efs_name
  
  
  performance_mode = "generalPurpose"
  tags = {
    Name = var.efstags
    project = "pinguimghosts"
    
  }
  encrypted = true
}

 resource "aws_efs_access_point" "sigom" {
  file_system_id = aws_efs_file_system.efs_system.id
   
   posix_user {
   gid      = 5000
   uid      = 5000

   }
   
   
  root_directory  {
   path = "varr.access_point"

   creation_info {
   owner_uid      = 5000
   owner_gid      = 5000
   permissions    = 1777
      }
  }
}

#subnets          = ["${var.subnets_privada_id[0]}" , "${var.subnets_privada_id[1]}"]

resource "aws_efs_mount_target" "efs-mt" {
   count = length(var.subnets_privada_id)
   file_system_id  = aws_efs_file_system.efs_system.id
   subnet_id =  "var.subnets_privada_id[count.index].id"
   security_groups = [var.sg_efs2]
 }



 












/* 

tinha var.subnet_ID_B qu etinha o id dado no output do modulo d eresdes mas devido ao problem não funciona.file_system_id
resource "aws_efs_mount_target" "mont_AZB" {
    count = var.subnet_b ? 1 : 0
  file_system_id = aws_efs_file_system.efs_system.id
  subnet_id      = var.subnet_ID_B
  security_groups = ["${aws_security_group.ecs_container_security_group.id}"]
}

resource "aws_efs_mount_target" "mont_AZC" {
    count = var.subnet_c ? 1 : 0
  file_system_id = aws_efs_file_system.efs_system.id
  subnet_id      = var.subnet_ID_C
  security_groups = ["${aws_security_group.ecs_container_security_group.id}"]
} */

#### dados com id de subnet  aqui coemtei o floco filez
/*  resource "local_file" "filecomefs_id_para_fargate" {
    content     = <<EOF
${aws_efs_file_system.efs_system.id}
EOF
    filename = "filecomefs_id_para_fargate"
}

data "local_file" "foo" {
    filename = "filecomefs_id_para_fargate"
} 
  */





