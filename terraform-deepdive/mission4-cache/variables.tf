variable "project_name" {
  type        = string
  description = "프로젝트 이름"
  default     = "yjp-deepdive"
}

variable "environment" {
  type        = string
  description = "배포 환경"
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment는 dev, staging, prod 중 하나여야 합니다."
  }
}

variable "aws_region" {
  type        = string
  description = "AWS 리전"
  default     = "eu-west-2"
}

variable "redis_node_type" {
  type        = string
  description = "Redis 노드 타입"
  default     = "cache.t3.micro"
}

variable "redis_num_cache_clusters" {
  type        = number
  description = "Redis 클러스터 수 (1=Single, 2+=Multi-AZ)"
  default     = 1
}

variable "snapshot_retention_limit" {
  type        = number
  description = "스냅샷 보관 기간 (일)"
  default     = 1
}