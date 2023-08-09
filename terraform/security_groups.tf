resource "aws_security_group" "ec2" {
  name        = "${var.ecs_cluster_name}-sg"
  description = "Allows ssh from anywhere, allow http only from alb security_group"
  vpc_id      = aws_vpc.jenkins.id

  tags = {
    Name = "${var.ecs_cluster_name}-sg"
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_alb.arn]
  }

  ingress {
    from_port       = var.agent_port
    to_port         = var.agent_port
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_alb.arn]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
  }
}
