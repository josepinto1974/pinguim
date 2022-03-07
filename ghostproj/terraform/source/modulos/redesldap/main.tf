##Este modulo construi todo a infra de redes, vpc, subnet, route tables, associação



#####


/* provider "aws" {
  profile    = "cross"
  region     = var.region
  assume_role {
    role_arn = "arn:aws:iam::920768381054:role/SysOps"
  }
} */



/* resource "aws_vpc" "vpc_cross" {
  cidr_block       = var.cdir_vpc
  enable_dns_hostnames = true
instance_tenancy = "default"

  tags = {
    Name = var.nome_vpc
  }

  
} */


####fazer ou nao a VPC de ldap


resource "aws_vpc" "vpc_ldap" {
  #count = var.fazer_subnet_privada ? 1 : 0
  cidr_block       = var.cdir_vpc_ldap
  enable_dns_hostnames = true
instance_tenancy = "default"

  tags = {
    Name = var.nome_vpc
  }

  
}


##subnet privada no ldap vpc


resource "aws_subnet" "private1_aza_ldap" {
    #count = var.fazer_subnet_privada ? 1 : 0
  vpc_id     = aws_vpc.vpc_ldap.id
  cidr_block = var.subnet_cdir_subnetpubl_aza_ldap_vpc
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = var.subnet_nome_subnetpriv_aza
  }
}





##naoestaaqui declarado


 


###Criar subnets

/* resource "aws_subnet" "private1_aza" {
    count = var.fazer_subnet_privada ? 1 : 0
  vpc_id     = aws_vpc.vpc_cross.id
  cidr_block = var.subnet_cdir_subnetpriv_aza
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = var.subnet_nome_subnetpriv_aza
  }
} */

 


##subnetpublica AZA

/* resource "aws_subnet" "subnetpublic1_aza" {
    count = var.fazer_subnet_publica ? 1 : 0
  vpc_id     = aws_vpc.vpc_cross.id
  cidr_block = var.subnet_cdir_subpublica_nat_aza
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = var.subnet_nome_subnetpublic_aza
  }
} */



####IGW###

/* resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_cross.id

  tags = {
    Name = var.igw_name
  }
} */
 

###Routetables

###############################
###VPC routing tables
###############################
/* resource "aws_route_table" "private_RT" {
 vpc_id = aws_vpc.vpc_cross.id
 tags = {
        Name = var.routetable_name
}
}
 */


/* resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.private_RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id

  depends_on = [aws_route_table.private_RT]
} */

/* resource "aws_main_route_table_association" "a" {
  vpc_id         = aws_vpc.vpc_cross.id
  route_table_id = aws_route_table.private_RT.id
}
  */


###Associar subnet às route aws_route_tables 


resource "aws_route_table_association" "private1_azc_association" {
    count = var.fazer_subnet_publica ? 1 : 0
  subnet_id      = aws_subnet.private1_aza[count.index].id
  route_table_id = aws_route_table.private_RT.id
}



##########################################
##OBTER ID da VPC com o LDAP
#########################################


#############################################
#PEERING
################################################
#############################################
#PEERING
################################################
## vpc_id: id da vpc que requisita a ligacao: vamos assumir que quem pede é a vpc que não tem o LDAP 



/* resource "aws_vpc_peering_connection" "LDAP" {
  #count = var.fazer_peering ? 1 : 0
  #aws_vpc.vpc_ldap.id
  peer_vpc_id   = aws_vpc.vpc_ldap.id
  vpc_id        = aws_vpc.vpc_cross.id 
  auto_accept   = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
 */