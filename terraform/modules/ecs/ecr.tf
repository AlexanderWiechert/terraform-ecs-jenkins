resource "aws_ecr_repository" "jenkins" {
  name = var.service_name
  tags = {
    Name = "${var.service_name}_ecr"
  }
}
