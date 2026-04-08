# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

# ElastiCache Replication Group (Redis)
resource "aws_elasticache_replication_group" "main" {
  replication_group_id = "${var.project_name}-redis"
  description          = "${var.project_name} Redis Replication Group"

  engine               = "redis"
  engine_version       = "7.1"
  node_type            = var.redis_node_type
  port                 = 6379
  parameter_group_name = "default.redis7"

  num_cache_clusters = var.redis_num_cache_clusters

  automatic_failover_enabled = var.redis_num_cache_clusters > 1 ? true : false
  multi_az_enabled           = var.redis_num_cache_clusters > 1 ? true : false

  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [var.sg_redis_id]

  transit_encryption_enabled = true
  auth_token                 = var.redis_auth_token
  auth_token_update_strategy = "ROTATE"
  at_rest_encryption_enabled = true

  maintenance_window       = "mon:03:00-mon:04:00"
  snapshot_window          = "01:00-02:00"
  snapshot_retention_limit = var.snapshot_retention_limit

  apply_immediately = var.apply_immediately

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = "${var.project_name}-redis"
  }
}

# SSM Parameter - Redis Endpoint 저장
resource "aws_ssm_parameter" "redis_host" {
  name  = "/${var.project_name}/redis/host"
  type  = "String"
  value = aws_elasticache_replication_group.main.primary_endpoint_address

  tags = {
    Name = "${var.project_name}-redis-host"
  }
}