output "sns_topic_arn" {
  value       = aws_sns_topic.order_events.arn
  description = "SNS Topic ARN"
}

output "sqs_queue_urls" {
  value       = { for k, v in aws_sqs_queue.main : k => v.url }
  description = "SQS 큐 URL 목록"
}

output "sqs_queue_arns" {
  value       = { for k, v in aws_sqs_queue.main : k => v.arn }
  description = "SQS 큐 ARN 목록"
}

output "dlq_queue_arns" {
  value       = { for k, v in aws_sqs_queue.dlq : k => v.arn }
  description = "DLQ ARN 목록"
}