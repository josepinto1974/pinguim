
   output "aws_vpc_vpc_cross_id" {
  value = "${aws_vpc.vpc.id}"
}



 output "subnets_privada_id" {
  value       = values(aws_subnet.private)[*].id
  description = "id de vpc cross"
  
} 




 output "subnets_publica_id" {
  value       = values(aws_subnet.public)[*].id
  description = "id de vpc cross"
  
} 




output "subnets_cross_idaLL" {
  value       = values(aws_subnet.private)[*].id
  description = "id de vpc cross"
  
}


output "subnets_cross_id1" {
  value       = values(aws_subnet.private)[1].id
  description = "id de vpc cross"
  
}



output "subnets_public_id1" {
  value       = values(aws_subnet.private)[1].id
  description = "id de vpc cross"
  
}


 output "subnets_public_id0" {
  value       = values(aws_subnet.private)[0].id
  description = "id de vpc cross"
  
} 




 output "vpc_cross_id" {
  value       = "${aws_vpc.vpc.id}"
  description = "id de vpc cross"
  
} 


  output aws_db_subnet_group_private {
 value = "${aws_db_subnet_group.private.id}"

}  



/* output aws_subnet_publica_aza_id {
 value = "${aws_subnet.subnetpublic1_aza_bastian.id}"

} */