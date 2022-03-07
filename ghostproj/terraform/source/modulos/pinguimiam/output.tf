/*  output "aws_iam" {
  value       = "${aws_iam_role.pinguim.id}"
  description = "aws_security_group__private_id"
  
}
 */

output "pinguim_proxy_role" {
  value       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
  description = "aws_security_group__private_id"
  
}


/* output "pinguim_proxy_role" {
  value       = "${aws_iam_role.aws_iam_role.arn}"
  description = "aws_security_group__private_id"
  
} */

output "pinguim_ecs_task_execution_role" {
  value       = "${aws_iam_role.ecsTaskExecutionRole.arn}"
  description = "aws_security_group__private_id"
  
}


/* output "pinguim_proxy_role" {
  value       = "${aws_iam_role.pinguim_cloudagent_role.arn}"
  description = "aws_security_group__private_id"
  
} */

/* output "pinguim_proxy_role" {
  value       = "${aws_iam_role.pinguim_cloudagent_role.arn}"
  description = "aws_security_group__private_id"
  
}
 */



output "aws_iam_instance_profile_ec2_profile_name" {
  value       = "${aws_iam_instance_profile.ec2_profile.name}"
  description = "aws_iam_instance_profile.ec2_profile.name"
  
}


output "iam_instance_profile" {
  value       = "${aws_iam_instance_profile.iam_instance_profile_cloudwatch.name}"
  description = "aws_security_group__private_id"
  
}


/* output "aws_iam_role_RDS_role" {
  value       = "${aws_iam_role.RDS_role.arn}"
  description = "aws_security_group__private_id"
  
} */


output "aws_iam_role_secrets_policy" {
  value       = "${aws_iam_role.secrets_policy.arn}"
  description = "aws_security_group__private_id"
  
}



output "aws_iam_role_enhanced_pinguim_monitoring" {
  value       = "${aws_iam_role.enhanced_pinguim_monitoring.arn}"
  description = "aws_security_group__private_id"
}


#######ECS



output "aws_iam_role_ecs-autoscale-role" {
  value       = "${aws_iam_role.ecs-autoscale-role.arn}"
  description = "aws_security_group__private_id"
}



output "aws_iam_lambda_role" {
  value       = "${aws_iam_role.lambda-role.arn}"
  description = "aws_security_group__private_id"
}