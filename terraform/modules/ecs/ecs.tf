data "template_file" "jenkins_task_template" {
  template = file("${path.module}/templates/jenkins.json.tpl")
  vars = {
    name      = "${var.ecs_cluster_name}"
    port      = "${var.container_port}"
    image     = "${aws_ecr_repository.jenkins.repository_url}"
    agent     = "${var.agent_port}"
    log_group = aws_cloudwatch_log_group.mb.name
    region    = var.region
  }
}

resource "aws_ecs_cluster" "jenkins" {
  name = var.ecs_cluster_name
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_task_definition" "jenkins" {
  family                = var.ecs_cluster_name
  container_definitions = data.template_file.jenkins_task_template.rendered

  volume {
    name      = "jenkins-home"
    host_path = "/ecs/jenkins-home"
  }
}

resource "aws_ecs_service" "jenkins" {
  name                 = var.jenkins_repository_url
  cluster              = aws_ecs_cluster.jenkins.id
  task_definition      = aws_ecs_task_definition.jenkins.arn
  desired_count        = var.desired_service_count
  depends_on           = [aws_autoscaling_group.jenkins]
  force_new_deployment = true
  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.ecs_cluster_name
    container_port   = var.container_port
  }
}


resource "aws_autoscaling_group" "jenkins" {
  name = var.ecs_cluster_name
  availability_zones        = ["${var.availability_zone}"]
  min_size                  = var.min_instance_size
  max_size                  = var.max_instance_size
  desired_capacity          = var.desired_instance_capacity
  health_check_type         = "EC2"
  health_check_grace_period = 300
  launch_configuration      = aws_launch_configuration.jenkins.name
  vpc_zone_identifier       = var.vpc_zone_identifier
  tag {
    key                 = "Name"
    value               = "Jenkins-ECS"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")
  vars = {
    aws_profile      = "${var.aws_profile}"
    s3_bucket        = "${var.s3_bucket}"
    ecs_cluster_name = "${var.ecs_cluster_name}"
    restore_backup   = "${var.restore_backup}"
  }
}

resource "aws_launch_configuration" "jenkins" {
  name_prefix                 = var.ecs_cluster_name
  image_id                    = lookup(var.amis, var.region)
  instance_type               = var.instance_type
  security_groups             = ["${var.aws_security_group}"]
  iam_instance_profile        = var.aws_iam_instance_profile
  key_name                    = var.key_name
  associate_public_ip_address = false
  user_data                   = data.template_file.user_data.rendered
  root_block_device{
    encrypted = true
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudwatch_log_group" "mb" {
  name              = var.ecs_cluster_name
  retention_in_days = 14
  kms_key_id        = aws_kms_key.jenkins.key_id
  tags = {
    Name        = var.ecs_cluster_name
    environment = var.environment
  }
}

resource "aws_kms_key" "jenkins" {
  description             = "cloudwatch-encrpytion"
}