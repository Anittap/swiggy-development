variable "cidr_block" {
  type        = string
  description = "cidr block for vpc"
}
variable "project_name" {
  type        = string
  description = "project name"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "region" {
  type        = string
  description = "project region"
}
variable "access_key" {
  type        = string
  description = "access key"
}
variable "secret_key" {
  type        = string
  description = "secret key"
}
variable "owner" {
  type        = string
  description = "project owner"
}
variable "bits" {
  type        = number
  description = "subnet bit to add"
}
variable "instance_type" {
  type        = map(any)
  description = "map of instance type"
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
  description = "ssh ports"
}
variable "ami_id_map" {
  type        = map(any)
  description = "map of ami ids"
}
variable "troubleshooting" {
  type        = bool
  description = "enable troubleshooting"
}
variable "bastion_ports" {
  type        = list(string)
  description = "bastion ports"
}
variable "enable_elb_health_checks" {
  type        = map(any)
  description = "enable elb health checks"
}
variable "min_size" {
  type        = number
  description = "min size"
}
variable "max_size" {
  type        = number
  description = "max size"
}
variable "desired_size" {
  type        = number
  description = "desired size"
}
variable "domain_name" {
  type        = string
  description = "domain name"
}
