output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_alb_dns" {
  value = aws_lb.public.dns_name
}

output "internal_alb_dns" {
  value = aws_lb.internal.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.main.endpoint
}

output "s3_bucket_name" {
  value = aws_s3_bucket.web.bucket
}

output "efs_id" {
  value = aws_efs_file_system.main.id
}