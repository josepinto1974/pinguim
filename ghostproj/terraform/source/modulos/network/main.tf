
###$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$




resource "aws_vpc" "vpc" {
  cidr_block = var.cdir_vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    "Name" = "VPCprimcipal"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "main"
  }
}


resource "aws_flow_log" "example" {
  log_destination      = var.aws_s3_bucket
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
}

##########$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$

########################
####################################


#begin#######public

resource "aws_route_table" "public" {
  for_each = var.public_subnet
  vpc_id   = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "rt_tags"
  }
}


resource "aws_subnet" "public" {
  for_each                = var.public_subnet
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = each.key
  }
}



resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  route_table_id = aws_route_table.public[each.key].id
  subnet_id      = each.value.id
  
}




#end public


#begin private

resource "aws_route_table" "private" {
  for_each = var.priv_subnet
  vpc_id   = aws_vpc.vpc.id

  

  tags = {
    Name = "rt_tags"
  }
}


resource "aws_subnet" "private" {
  for_each                = var.priv_subnet
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false
  tags = {
    Name = each.key
  }
}



resource "aws_route_table_association" "private" {
  for_each       = aws_subnet.private
  route_table_id = aws_route_table.private[each.key].id
  subnet_id      = each.value.id
}



#End private





#https://stackoverflow.com/questions/59097391/terraform-how-to-supply-attributes-of-resources-which-where-created-using-one-r

 resource "aws_db_subnet_group" "private" {
  name       = "my_database_subnet_group"
 subnet_ids = values(aws_subnet.private)[*].id

  tags = {
    Name = "pinguimsubnetgroup"
  }
} 






 resource "aws_db_subnet_group" "public" {
  name       = "my_database_subnet_group_publico"
 subnet_ids = values(aws_subnet.public)[*].id

  tags = {
    Name = "pinguimsubnetpublico"
  }
} 