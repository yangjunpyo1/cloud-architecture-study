variable "project_name" {
  type        = string
  description = "프로젝트 이름"
  default     = "deepdive"
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

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR 블록"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "퍼블릭 서브넷 CIDR 목록"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "프라이빗 서브넷 CIDR 목록"
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}