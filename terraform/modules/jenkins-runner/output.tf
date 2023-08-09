output "subnet_id" {
  value = aws_subnet.jenkins_runner.id
}

output "security_group_name" {
  value = aws_security_group.jenkins_runner.name
}

output "jenkins_runner_ami_id" {
  value = data.aws_ami.jenkins_runner.id
}
