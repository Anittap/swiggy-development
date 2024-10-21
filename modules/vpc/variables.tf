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
