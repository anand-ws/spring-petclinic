resource "aws_sns_topic" "sns_topic" {
  count = var.create_sns_topic ? 1 : 0
  name  = var.sns_topic_name
  tags  = var.tags
}

variable "create_sns_topic" {
  type        = bool
  description = "create sns_topic ?"
}

variable "sns_topic_name" {
  type        = string
  description = "SNS topic"
  default     = "default_value"
}

variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}


output "sns_id" {
  value = aws_sns_topic.sns_topic.*.id
}

output "sns_arn" {
  value = aws_sns_topic.sns_topic.*.arn
}
