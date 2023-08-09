data "aws_region" "current" {
}

variable "service_name" {
  type = string
}

variable "dns_zone_name" {
  type = string
}

variable "aws_dns_name" {
  type = string
}

variable "aws_dns_zone" {
  type = string
}
variable "environment" {
  type = string
}

variable "dns_zone_holder_account" {
  type = string
}

variable "region" {
  type = string
}
