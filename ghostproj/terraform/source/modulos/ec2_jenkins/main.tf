##EC2 jenkins_server_linux

#Para podermos ter as automatizacoes integradas com os ip provados, este modulo vai se encarregar de criara todas as inatencias de jenkins do 
#cross não erapossivle usar o modulo singular por causa da necessidade de termos acesso ao ip privado do sever.
#Se usasse um modulo generico essa variavel em output iria mudar em função do modulo corrido.
#Assim temos a garantia de que temos o ip privado ada ec2 certa.

##FICA
resource "aws_instance" "jenkins_server_linux" {
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

 user_data = <<-EOF
 #!/bin/bash
 sudo systemctl restart jenkins
              #!/bin/bash
              echo "create ssh key"
              ssh-keygen -f ~/.ssh/keyssh -t ecdsa -b 521 -q -N ""
              ssh-copy-id -i keyssh.pub -o StrictHostKeyChecking=no ec2-user@${var.bastian_ip_privado}
              sudo service jenkins start
              EOF


  tags = {
    Name = var.nomeec2
  }
}


resource "aws_instance" "jenkins_slave_linux" {
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

 user_data    = <<EOF


    #!/bin/bash
 sudo echo "ttt" > $HOME/olaum
 sudo  echo "PPPPP" > filever
 #echo "ttt" > /root/olaum
 sudo iptables -F
    echo "config jenkinsfile"
    sudo cp  /home/ec2-user/jenkins-agent-run.sh /tmp/bck_jenkins-agent-run.sh
    sudo cp  /home/ec2-user/jenkins-agent-run.sh /tmp/cbbck_jenkins-agent-run.sh
    $ee="${aws_instance.jenkins_server_linux.private_ip}"
     echo $ee > /tmp/ipdados
     echo "pp" >> /tmp/ipdados
     echo "$ee" > /tmp/ipdados
     #ee=`curl  http://169.254.169.254/latest/meta-data/local-ipv4` 
   
     sudo cp /tmp/ipdados /home/ec2-user/
     sudo cp /tmp/ipdados /home/ec2-user/ipdadossemsudo
     cp /tmp/ipdados /home/ec2-user/ipdadossemsudo_mesmo
      sudo sed -i "s/172.24.2.65/${aws_instance.jenkins_server_linux.private_ip}/g"  /tmp/bck_jenkins-agent-run.sh
      cp /tmp/bck_jenkins-agent-run.sh $HOME
      sudo cp /tmp/bck_jenkins-agent-run.sh /home/ec2-user/jenkins-agent-run.sh
      chown  ec2-user:ec2-user /home/ec2-user/jenkins-agent-run.sh
      
              ssh-keygen -f ~/.ssh/keyssh -t ecdsa -b 521 -q -N ""
              ssh-copy-id -i keyssh.pub -o StrictHostKeyChecking=no ec2-user@var.bastian_ip_privado}
              
              cd /home/ec2-user
              nohup ./jenkins-agent-run.sh &
EOF


  tags = {
    Name = var.nomeec2
  }
}



###EC2 S.G 

resource "aws_security_group" "jpteste" {
  name        = var.nome_SG_bastian
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
