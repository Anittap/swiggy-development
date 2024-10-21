output "public_dns" {
  value = length(aws_instance.troubleshooting) > 0 ? aws_instance.troubleshooting.public_dns : null
}
