variable "project_name" {
  type        = string
  description = "프로젝트 이름"
}

variable "environment" {
  type        = string
  description = "배포 환경"
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