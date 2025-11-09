variable "app_name" {
  description = "The name of the application"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the instance will be deployed"
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t3.small"
}

variable "subnet_id" {
  description = "The subnet ID where the instance will be launched"
  type        = string
}


variable "instance_state" {
  description = "The desired state of the EC2 instance (e.g., 'running', 'stopped')"
  type        = string
  default     = "running"
}
