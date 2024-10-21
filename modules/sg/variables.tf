variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "frontend_ports" {
  type        = list(string)
  description = "frontend ports"
}
variable "backend_ports" {
  type        = list(string)
  description = "backend ports"
}
variable "ssh_port" {
  type        = string
  description = "ssh port"
}
variable "bastion_ports" {
  type        = list(string)
  description = "bastion ports"
}
variable "swiggy_vpc_id" {
  type        = string
  description = "vpc id"
}
variable "troubleshooting" {
  type        = bool
  description = "enable troubleshooting sg rules"
}
