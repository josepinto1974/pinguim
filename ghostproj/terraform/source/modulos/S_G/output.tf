 output "aws_security_group__ecs_tasks_id" {
  value       = "${aws_security_group.ecs_tasks.id}"
  description = "aws_security_group__ecs_tasks_id"
  
} 


 output "aws_security_group_alb_id_id" {
  value       = "${aws_security_group.alb.id}"
  description = "aws_security_group__ecs_tasks_id"
  
} 


 output "aws_security_group_ecs_tasks" {
  value       = "${aws_security_group.ecs_tasks.id}"
  description = "aws_security_group__ecs_tasks_id"
  
} 





 output "aws_security_group_efs" {
  value       = "${aws_security_group.efs.id}"
  description = "aws_security_group__ecs_tasks_id"
  
}





 output "aws_security_group__rds" {
  value       = "${aws_security_group.rds.id}"
  description = "aws_security_group__ecs_tasks_id"
  
}
