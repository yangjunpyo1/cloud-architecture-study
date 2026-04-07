terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "yjp-deepdive-terraform-state"
    key    = "mission2/terraform.tfstate"
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

# Redis AUTH 토큰 생성
resource "random_password" "redis_auth" {
  length           = var.password_length
  special          = true
  override_special = "!&#$^<>-"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
}

# DB 비밀번호 생성
resource "random_password" "db_password" {
  length           = var.password_length
  special          = true
  override_special = "!&#$^<>-"
  min_upper        = 2
  min_lower        = 2
  min_numeric      = 2
}

# SSM Parameter Store - 앱 포트
resource "aws_ssm_parameter" "app_port" {
  name  = "/${var.project_name}/app/port"
  type  = "String"
  value = "8080"

  tags = {
    Name = "${var.project_name}-app-port"
  }
}

# SSM Parameter Store - 로그 레벨
resource "aws_ssm_parameter" "log_level" {
  name  = "/${var.project_name}/app/log_level"
  type  = "String"
  value = var.environment == "prod" ? "WARN" : "DEBUG"

  tags = {
    Name = "${var.project_name}-log-level"
  }
}

# SSM Parameter Store - Redis 포트
resource "aws_ssm_parameter" "redis_port" {
  name  = "/${var.project_name}/redis/port"
  type  = "String"
  value = "6379"

  tags = {
    Name = "${var.project_name}-redis-port"
  }
}

# SSM Parameter Store - Feature Flag
resource "aws_ssm_parameter" "cache_enabled" {
  name  = "/${var.project_name}/feature/cache_enabled"
  type  = "String"
  value = "true"

  tags = {
    Name = "${var.project_name}-cache-enabled"
  }
}

# Secrets Manager - Redis AUTH 토큰
resource "aws_secretsmanager_secret" "redis_auth" {
  name                    = "${var.project_name}/redis-auth-token"
  recovery_window_in_days = var.recovery_window_in_days

  tags = {
    Name = "${var.project_name}-redis-auth-token"
  }
}

resource "aws_secretsmanager_secret_version" "redis_auth" {
  secret_id     = aws_secretsmanager_secret.redis_auth.id
  secret_string = random_password.redis_auth.result
}

# Secrets Manager - DB 접속 정보
resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = "${var.project_name}/db-credentials"
  recovery_window_in_days = var.recovery_window_in_days

  tags = {
    Name = "${var.project_name}-db-credentials"
  }
}

resource "aws_secretsmanager_secret_version" "db_credentials" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    host     = "mydb.rds.amazonaws.com"
    port     = 5432
    username = "dbadmin"
    password = random_password.db_password.result
  })
}

# Secrets Manager - 외부 API 키
resource "aws_secretsmanager_secret" "external_api_key" {
  name                    = "${var.project_name}/external-api-key"
  recovery_window_in_days = var.recovery_window_in_days

  tags = {
    Name = "${var.project_name}-external-api-key"
  }
}

resource "aws_secretsmanager_secret_version" "external_api_key" {
  secret_id     = aws_secretsmanager_secret.external_api_key.id
  secret_string = "placeholder-api-key-replace-in-prod"
}