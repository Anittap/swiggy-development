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
variable "owner" {
  type        = string
  description = "project owner"
}
variable "instance_type" {
  type        = map(any)
  description = "map of instance type"
}
variable "ami_id_map" {
  type        = map(any)
  description = "map of ami ids"
}
variable "key_pair" {
  type        = string
  description = "key pair"
}

variable "sg_freedom_id" {
  type        = string
  description = "sg freedom"
}
variable "subnet_id" {
  type        = string
  description = "subnet id"
}