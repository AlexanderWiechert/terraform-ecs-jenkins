resource "aws_security_group" "jenkins_runner" {
  name   = "jenkins_runner"
  vpc_id = aws_vpc.jenkins_runner.id
  tags   = var.baseTags
}

resource "aws_security_group_rule" "allow_ssh_incoming" {
  from_port = 22
  protocol = "tcp"
  security_group_id = aws_security_group.jenkins_runner.id
  to_port = 22
  type = "ingress"
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_all_outgoing" {
  from_port = 0
  protocol = "-1"
  security_group_id = aws_security_group.jenkins_runner.id
  to_port = 0
  type = "egress"
  cidr_blocks = ["0.0.0.0/0"]
}
