output "redis_auth_token" {
  value       = random_password.redis_auth.result
  sensitive   = true
  description = "Redis AUTH 토큰"
}

output "redis_auth_secret_arn" {
  value       = aws_secretsmanager_secret.redis_auth.arn
  description = "Redis AUTH Secret ARN"
}

output "db_secret_arn" {
  value       = aws_secretsmanager_secret.db_credentials.arn
  description = "DB 접속 정보 Secret ARN"
}

output "ssm_parameter_prefix" {
  value       = "/${var.project_name}"
  description = "SSM Parameter 경로 prefix"
}

