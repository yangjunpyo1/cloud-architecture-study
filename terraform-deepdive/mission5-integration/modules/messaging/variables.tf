variable "project_name" {
  type        = string
  description = "프로젝트 이름"
}

variable "environment" {
  type        = string
  description = "배포 환경"
}

variable "queues" {
  type = map(object({
    visibility_timeout = number
    max_receive_count  = number
    message_retention  = number
  }))
  description = "SQS 큐 설정"
}