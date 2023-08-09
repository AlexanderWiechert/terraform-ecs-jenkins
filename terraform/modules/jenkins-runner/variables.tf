variable "baseTags" {
  type = map(string)
  description = "AWS Tagds to use"
}

variable "build_number" {
  type = string
  description = "Increase the build number to trigger an new ami build with packer"
  default = 4
}

variable "aws_profile" {
  type = string
  description = "Local AWS Profile to build the AWS Ami for the jenkins runner"
}

variable "environment" {
  type = string
  description = "Environment to use"
}

variable "vpc_zone_identifier" {
  type = string
  description = "VPC ID"
}
