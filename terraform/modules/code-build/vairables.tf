variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket to store artifacts"
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket to store artifacts"
  type        = string
}
