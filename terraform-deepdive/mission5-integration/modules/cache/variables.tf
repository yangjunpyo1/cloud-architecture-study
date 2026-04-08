variable "project_name" {
  type        = string
  description = "프로젝트 이름"
}

variable "environment" {
  type        = string
  description = "배포 환경"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "프라이빗 서브넷 ID 목록"
}

variable "sg_redis_id" {
  type        = string
  description = "Redis 보안 그룹 ID"
}

variable "redis_auth_token" {
  type        = string
  description = "Redis AUTH 토큰"
  sensitive   = true
}

variable "redis_node_type" {
  type        = string
  description = "Redis 노드 타입"
  default     = "cache.t3.micro"
}

variable "redis_num_cache_clusters" {
  type        = number
  description = "Redis 클러스터 수"
  default     = 1
}

variable "snapshot_retention_limit" {
  type        = number
  description = "스냅샷 보관 기간 (일)"
  default     = 1
}

variable "apply_immediately" {
  type        = bool
  description = "즉시 적용 여부"
  default     = true
}