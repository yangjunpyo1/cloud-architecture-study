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

variable "queues" {
  type = map(object({
    visibility_timeout    = number
    max_receive_count     = number
    message_retention     = number
  }))
  description = "SQS 큐 설정"
  default = {
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