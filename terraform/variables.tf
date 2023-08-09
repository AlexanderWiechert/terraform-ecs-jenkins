variable "profile" {
  type = string
}

variable "profile_qa" {
  type        = string
  description = "AWS profile to use for qa"
}

variable "dns_zone_holder_account" {
  type        = string
  description = "Local AWS profile to use for the AWS account where the dns zone is maintened"
}

variable "region" {
  type    = string
  default = "eu-central-1"
}

variable "service_name" {
  type    = string
  default = "jenkins"
}

variable "availability_zone" {
  description = "The availability zone"
  default     = "eu-central-1b"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
  default     = "jenkins-ecs"
}

variable "amis" {
  description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
  default = {
    eu-central-1 = "ami-0fe4cfe8d04ec091e"
  }
}

variable "instance_type" {
  default = "t3.large"
}

variable "key_name" {
  default     = "devops-tf"
  description = "SSH key name in your AWS account for AWS instances."
}

variable "min_instance_size" {
  default     = 1
  description = "Minimum number of EC2 instances."
}

variable "max_instance_size" {
  default     = 2
  description = "Maximum number of EC2 instances."
}

variable "desired_instance_capacity" {
  default     = 1
  description = "Desired number of EC2 instances."
}

variable "desired_service_count" {
  default     = 1
  description = "Desired number of ECS services."
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket where remote state and Jenkins data will be stored."
}

variable "restore_backup" {
  default     = true
  description = "Whether or not to restore Jenkins backup."
}

variable "jenkins_repository_url" {
  default     = "jenkins"
  description = "ECR Repository for Jenkins."
}

variable "container_port" {
  default     = "8080"
  description = "Docker Container Port."
}

variable "agent_port" {
  default     = "50000"
  description = "Jenins Agent Port."
}

variable "dns_zone_name" {
  type = string
}

variable "build_trigger" {
  default = "7"
}
