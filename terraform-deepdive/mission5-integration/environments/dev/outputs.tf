output "vpc_id" {
  value       = module.networking.vpc_id
  description = "VPC ID"
}

output "private_subnet_ids" {
  value       = module.networking.private_subnet_ids
  description = "프라이빗 서브넷 ID 목록"
}

output "public_subnet_ids" {
  value       = module.networking.public_subnet_ids
  description = "퍼블릭 서브넷 ID 목록"
}

output "sns_topic_arn" {
  value       = module.messaging.sns_topic_arn
  description = "SNS Topic ARN"
}

output "sqs_queue_urls" {
  value       = module.messaging.sqs_queue_urls
  description = "SQS 큐 URL 목록"
}

output "redis_primary_endpoint" {
  value       = module.cache.redis_primary_endpoint
  description = "Redis Primary Endpoint"
}

output "redis_reader_endpoint" {
  value       = module.cache.redis_reader_endpoint
  description = "Redis Reader Endpoint"
}

output "redis_auth_secret_arn" {
  value       = module.secrets.redis_auth_secret_arn
  description = "Redis AUTH Secret ARN"
}