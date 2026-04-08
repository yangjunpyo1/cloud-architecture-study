output "redis_primary_endpoint" {
  value       = aws_elasticache_replication_group.main.primary_endpoint_address
  description = "Redis Primary Endpoint (쓰기용)"
}

output "redis_reader_endpoint" {
  value       = aws_elasticache_replication_group.main.reader_endpoint_address
  description = "Redis Reader Endpoint (읽기용)"
}

output "redis_port" {
  value       = aws_elasticache_replication_group.main.port
  description = "Redis 포트"
}

output "redis_subnet_group_name" {
  value       = aws_elasticache_subnet_group.main.name
  description = "Redis Subnet Group 이름"
}