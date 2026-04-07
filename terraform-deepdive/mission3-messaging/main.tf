terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "yjp-deepdive-terraform-state"
    key    = "mission3/terraform.tfstate"
    region = "eu-west-2"
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  }
}

data "aws_caller_identity" "current" {}

# SNS Topic
resource "aws_sns_topic" "order_events" {
  name = "${var.project_name}-order-events"

  tags = {
    Name = "${var.project_name}-order-events"
  }
}

# SQS DLQ
resource "aws_sqs_queue" "dlq" {
  for_each = var.queues

  name                      = "${var.project_name}-${each.key}-dlq"
  message_retention_seconds = 1209600 # 14일

  tags = {
    Name = "${var.project_name}-${each.key}-dlq"
  }
}

# SQS Main Queue
resource "aws_sqs_queue" "main" {
  for_each = var.queues

  name                      = "${var.project_name}-${each.key}"
  visibility_timeout_seconds = each.value.visibility_timeout
  message_retention_seconds  = each.value.message_retention

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq[each.key].arn
    maxReceiveCount     = each.value.max_receive_count
  })

  tags = {
    Name = "${var.project_name}-${each.key}"
  }
}

# DLQ Redrive Allow Policy
resource "aws_sqs_queue_redrive_allow_policy" "dlq" {
  for_each = var.queues

  queue_url = aws_sqs_queue.dlq[each.key].id
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = [aws_sqs_queue.main[each.key].arn]
  })
}

# SQS Queue Policy (SNS → SQS 권한)
resource "aws_sqs_queue_policy" "main" {
  for_each = var.queues

  queue_url = aws_sqs_queue.main[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "sqs:SendMessage"
        Resource  = aws_sqs_queue.main[each.key].arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.order_events.arn
          }
        }
      }
    ]
  })
}

# SNS → SQS 구독
resource "aws_sns_topic_subscription" "order_events" {
  for_each = var.queues

  topic_arn            = aws_sns_topic.order_events.arn
  protocol             = "sqs"
  endpoint             = aws_sqs_queue.main[each.key].arn
  raw_message_delivery = true
}