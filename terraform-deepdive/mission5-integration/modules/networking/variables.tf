variable "project_name" {
  type        = string
  description = "프로젝트 이름"
}

variable "environment" {
  type        = string
  description = "배포 환경"
}

variable "aws_region" {
  type        = string
  description = "AWS 리전"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR 블록"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "퍼블릭 서브넷 CIDR 목록"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "프라이빗 서브넷 CIDR 목록"
}

variable "enable_nat_gateway" {
  type        = bool
  description = "NAT Gateway 활성화 여부"
  default     = true
}