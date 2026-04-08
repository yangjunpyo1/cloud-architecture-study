variable "project_name" {
  type        = string
  description = "프로젝트 이름"
  default     = "yjp-deepdive"
}

variable "environment" {
  type        = string
  description = "배포 환경"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  description = "AWS 리전"
  default     = "eu-west-2"
}