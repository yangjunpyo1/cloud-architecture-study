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

variable "recovery_window_in_days" {
  type        = number
  description = "Secrets Manager 삭제 복구 기간"
  default     = 7
}

variable "password_length" {
  type        = number
  description = "생성할 비밀번호 길이"
  default     = 32
}