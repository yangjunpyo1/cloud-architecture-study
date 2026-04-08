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
    key    = "mission5/dev/terraform.tfstate"
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

# Networking 모듈
module "networking" {
  source = "../../modules/networking"

  project_name         = var.project_name
  environment          = var.environment
  aws_region           = var.aws_region
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
  enable_nat_gateway   = true
}

# Secrets 모듈
module "secrets" {
  source = "../../modules/secrets"

  project_name            = var.project_name
  environment             = var.environment
  recovery_window_in_days = 7
  password_length         = 32
}

# Messaging 모듈
module "messaging" {
  source = "../../modules/messaging"

  project_name = var.project_name
  environment  = var.environment
  queues = {
    "order-process" = {
      visibility_timeout = 60
      max_receive_count  = 3
      message_retention  = 345600
    }
    "order-notify" = {
      visibility_timeout = 30
      max_receive_count  = 5
      message_retention  = 345600
    }
    "order-analytics" = {
      visibility_timeout = 120
      max_receive_count  = 3
      message_retention  = 345600
    }
  }
}

# Cache 모듈
module "cache" {
  source = "../../modules/cache"

  project_name             = var.project_name
  environment              = var.environment
  private_subnet_ids       = module.networking.private_subnet_ids
  sg_redis_id              = module.networking.sg_redis_id
  redis_auth_token         = module.secrets.redis_auth_token
  redis_node_type          = "cache.t3.micro"
  redis_num_cache_clusters = 1
  snapshot_retention_limit = 1
  apply_immediately        = true
}