##EC2 jenkins_server_linux

##FICA
resource "aws_instance" "criar_ec2" {
  ami               = var.amilinux_master
  availability_zone = "eu-west-2a"
  instance_type     = var.ec2tipo
   key_name = var.key_par_name
   monitoring = true
   iam_instance_profile = var.iamrole_name
   #subnet_id = aws_subnet.private1_aza.id
   subnet_id = var.aws_subnet_private1_aza_id
   associate_public_ip_address = "1"
  vpc_security_group_ids = [aws_security_group.jpteste.id]
   
 user_data = var.user_data


  tags = {
    Name = var.nomeec2
  }
}




###EC2 S.G 

resource "aws_security_group" "jpteste" {
  name        = var.nome_SG_jpteste
  description = "jpteste"

  vpc_id      = var.aws_vpc_vpc_cross_id



  ingress {
    description = "inboundrulesremoteacess"
    from_port   = "0"
    to_port     = "0"
    protocol    = "6"
    cidr_blocks = [var.cdir_vpc]
  }

 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.nome_SG_jpteste
  }
}
