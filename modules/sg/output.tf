output "sg_frontend_id" {
  value = aws_security_group.lb.id
}
output "sg_backend_id" {
  value = aws_security_group.backend.id
}
output "sg_bastion_id" {
  value = aws_security_group.bastion.id
}
output "sg_freedom_id" {
  value = length(aws_security_group.freedom) > 0 ? aws_security_group.freedom[0].id : null
}
