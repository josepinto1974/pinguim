/* output "aws_vpc_vpc_cross_id" {
  value       = "${aws_vpc.vpc_cross.id}"
  description = "vpc_id id."
  
}

 */


/* output "aws_subnet_private1_aza_id" {
  value = "$(aws_subnet.private1_aza.id)"
} */

 output "aws_vpc_vpc_cross_id" {
  value = "$(aws_vpc.vpc_cross.id)"
} 

  output "aws_subnet_private1_aza_id" {
  value = "$(aws_subnet.private1_aza.id)"
}

   output "aws_subnet_publica_aza_id" {
  value = "$(aws_subnet.subnetpublic1_aza.id)"
} 

 output "vpc_ldap_id" {
  value       = "${aws_vpc.vpc_ldap.id}"
  description = "The password for logging in to the database."
  
} 

/* output "vpc_cross_id" {
  value       = "${aws_vpc.vpc_cross.id}"
  description = "id de vpc cross"
  
} */

###epereincia

output "vpc_cross_id" {
    value = "${var.create_alb ? "${aws_vpc.vpc_cross.id}" : ""}"
}