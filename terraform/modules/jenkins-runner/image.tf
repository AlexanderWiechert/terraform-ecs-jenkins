data "aws_ami" "jenkins_runner" {
  most_recent = true
  owners = [
    "self"
  ]

  filter {
    name = "name"
    values = [
      "jenkins-runner-*"
    ]
  }

  filter {
    name = "root-device-type"
    values = [
      "ebs"
    ]
  }

  filter {
    name = "virtualization-type"
    values = [
      "hvm"
    ]
  }

  filter {
    name = "state"
    values = [
      "available"]
  }

  depends_on = [
    null_resource.aws_ami_build_jenkins_runner
  ]
}

resource "null_resource" "aws_ami_build_jenkins_runner" {
  triggers = {
    build_numer = var.build_number
  }
  provisioner "local-exec" {
    interpreter = [
      "/bin/bash",
      "-c"]
    command = join(" ", [
      "cd ../packer/ && packer build",

      # Current AWS Profile to use
      "-var aws_profile=${var.aws_profile}",

      # Current terraform environment to build the ami for
      "-var environment=${var.environment}",

      "jenkins_runner.json"
    ])
  }
}
