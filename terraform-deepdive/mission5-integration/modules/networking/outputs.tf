output "vpc_id" {
  value       = aws_vpc.main.id
  description = "VPC ID"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "퍼블릭 서브넷 ID 목록"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id
  description = "프라이빗 서브넷 ID 목록"
}

output "sg_web_id" {
  value       = aws_security_group.web.id
  description = "웹 보안 그룹 ID"
}

output "sg_app_id" {
  value       = aws_security_group.app.id
  description = "앱 보안 그룹 ID"
}

output "sg_redis_id" {
  value       = aws_security_group.redis.id
  description = "Redis 보안 그룹 ID"
}

output "sg_vpce_id" {
  value       = aws_security_group.vpce.id
  description = "VPC Endpoint 보안 그룹 ID"
}

output "app_role_arn" {
  value       = aws_iam_role.app.arn
  description = "앱 IAM Role ARN"
}

output "app_instance_profile_name" {
  value       = aws_iam_instance_profile.app.name
  description = "EC2 인스턴스 프로파일 이름"
}

output "nat_gateway_ip" {
  value       = var.enable_nat_gateway ? aws_eip.nat[0].public_ip : null
  description = "NAT Gateway 퍼블릭 IP"
}