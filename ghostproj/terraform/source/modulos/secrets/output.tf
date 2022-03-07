 output "aws_secretsmanager_secret_version_rdspassword" {
  value       = "${aws_secretsmanager_secret_version.rdspassword.arn}"
  description = "aws_secretsmanager_secret_version rdspassword"
  
} 



