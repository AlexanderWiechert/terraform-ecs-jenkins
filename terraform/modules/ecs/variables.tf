variable "service_name" {
  type = string
}

variable "region" {
  type = string
}

variable "restore_backup" {
  type = string
}

variable "ecs_cluster_name" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "profile_qa" {
  type = string
}

variable "dns_zone_holder_account" {
  type = string
}

variable "container_port" {
  # type = number
}

variable "agent_port" {
  # type = number
}

variable "ec2_security_group" {
  type = string
}

variable "aws_iam_instance_profile" {
  type = string
}

variable "key_name" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "amis" {

}

variable "aws_security_group" {
  type = string
}

variable "vpc_zone_identifier" {

}

variable "desired_instance_capacity" {
  type = number
}

variable "availability_zone" {
  type = string
}

variable "min_instance_size" {
  type = number
}

variable "max_instance_size" {
  type = number
}

variable "desired_service_count" {
  type = number
}

variable "target_group_arn" {

}

variable "jenkins_repository_url" {
  type = string
}

variable "build_trigger" {
  type = string
}

variable "jenkins_fqdn" {
  type = string
}

variable "environment" {
  type = string
}

variable "jenkins_runner_subnet_id" {
  type = string
}
