terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "yjp-deepdive-terraform-state"
    key    = "mission4/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

# Mission 1 Remote State 참조
data "terraform_remote_state" "mission1" {
  backend = "s3"
  config = {
    bucket = "yjp-deepdive-terraform-state"
    key    = "mission1/terraform.tfstate"
    region = "eu-west-2"
  }
}

# Mission 2 Remote State 참조
data "terraform_remote_state" "mission2" {
  backend = "s3"
  config = {
    bucket = "yjp-deepdive-terraform-state"
    key    = "mission2/terraform.tfstate"
    region = "eu-west-2"
  }
}

# ElastiCache Subnet Group
resource "aws_elasticache_subnet_group" "main" {
  name       = "${var.project_name}-redis-subnet-group"
  subnet_ids = data.terraform_remote_state.mission1.outputs.private_subnet_ids

  tags = {
    Name = "${var.project_name}-redis-subnet-group"
  }
}

# ElastiCache Replication Group (Redis)
resource "aws_elasticache_replication_group" "main" {
  replication_group_id = "${var.project_name}-redis"
  description          = "${var.project_name} Redis Replication Group"

  # 엔진 설정
  engine               = "redis"
  engine_version       = "7.1"
  node_type            = var.redis_node_type
  port                 = 6379
  parameter_group_name = "default.redis7"

  # 클러스터 수
  num_cache_clusters = var.redis_num_cache_clusters

  # 고가용성 (클러스터 2개 이상일 때만)
  automatic_failover_enabled = var.redis_num_cache_clusters > 1 ? true : false
  multi_az_enabled           = var.redis_num_cache_clusters > 1 ? true : false

  # 네트워크
  subnet_group_name  = aws_elasticache_subnet_group.main.name
  security_group_ids = [data.terraform_remote_state.mission1.outputs.sg_redis_id]

  # 보안
  transit_encryption_enabled = true
  auth_token                 = data.terraform_remote_state.mission2.outputs.redis_auth_token
  auth_token_update_strategy = "ROTATE"
  at_rest_encryption_enabled = true

  # 유지보수
  maintenance_window       = "mon:03:00-mon:04:00"
  snapshot_window          = "01:00-02:00"
  snapshot_retention_limit = var.snapshot_retention_limit

  # 배포
  apply_immediately = true

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