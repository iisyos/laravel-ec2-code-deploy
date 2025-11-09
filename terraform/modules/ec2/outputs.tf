output "public_dns" {
  value = aws_instance.app.public_dns
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IP address (if assigned)"
  value       = aws_instance.app.public_ip
}
