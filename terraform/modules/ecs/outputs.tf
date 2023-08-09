output "docker_image" {
  value = aws_ecr_repository.jenkins.repository_url
}
