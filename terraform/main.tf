provider "aws" {
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::ACCOUNTID:role/G-Admin"
  }
}

terraform {
  backend "s3" {
  }
}

module "ecs" {
  source                    = "./modules/ecs"
  region                    = var.region
  service_name              = var.service_name
  restore_backup            = var.restore_backup
  ecs_cluster_name          = var.ecs_cluster_name
  s3_bucket                 = var.s3_bucket
  aws_profile               = var.profile
  dns_zone_holder_account   = var.dns_zone_holder_account
  profile_qa                = var.profile_qa
  container_port            = var.container_port
  agent_port                = var.agent_port
  ec2_security_group        = aws_security_group.ec2.id
  aws_iam_instance_profile  = aws_iam_instance_profile.iam_instance_profile.name
  key_name                  = var.key_name
  instance_type             = var.instance_type
  amis                      = var.amis
  aws_security_group        = aws_security_group.ec2.id
  vpc_zone_identifier       = aws_subnet.jenkins.*.id
  availability_zone         = var.availability_zone
  min_instance_size         = var.min_instance_size
  max_instance_size         = var.max_instance_size
  desired_instance_capacity = var.desired_instance_capacity
  target_group_arn          = aws_alb_target_group.jenkins.0.arn
  desired_service_count     = var.desired_service_count
  jenkins_repository_url    = var.jenkins_repository_url
  build_trigger             = var.build_trigger
  jenkins_fqdn              = module.dns.fqdn_name
  environment               = terraform.workspace
  jenkins_runner_subnet_id  = module.jenkins_runner.subnet_id
}

module "dns" {
  source                  = "./modules/dns"
  region                  = var.region
  aws_dns_name            = aws_alb.jenkins.dns_name
  aws_dns_zone            = aws_alb.jenkins.zone_id
  dns_zone_name           = var.dns_zone_name
  service_name            = var.service_name
  environment             = terraform.workspace
  dns_zone_holder_account = var.dns_zone_holder_account
}

module "jenkins_runner" {
  source      = "./modules/jenkins-runner"
  aws_profile = var.profile
  baseTags    = {}
  environment = terraform.workspace
}
