resource "aws_iam_role" "host_role_jenkins" {
  name               = "host_role_${var.ecs_cluster_name}"
  assume_role_policy = file("policies/ecs-role.json")
}

resource "aws_iam_role_policy" "instance_role_policy_jenkins" {
  name   = "instance_role_policy_${var.ecs_cluster_name}"
  policy = file("policies/ecs-instance-role-policy.json")
  role   = aws_iam_role.host_role_jenkins.id
}

resource "aws_iam_instance_profile" "iam_instance_profile" {
  name = "iam_instance_profile_${var.ecs_cluster_name}"
  path = "/"
  role = aws_iam_role.host_role_jenkins.name
}
