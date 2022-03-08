/*  output "RDS_endpoint" {
  value       = trim("${aws_db_instance.nova.endpoint}", ":1521")
  description = "aws_security_group__ALB_id"
  
}  */

  output "rdsproxy_endpoint" {
  value       = "${aws_db_proxy.pinguim.endpoint}"
  description = "rdsproxy_endpoint"
  
}   