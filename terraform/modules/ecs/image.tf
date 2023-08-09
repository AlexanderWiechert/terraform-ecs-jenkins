data "template_file" "jenkins_yaml" {
  template = file("${path.cwd}/${path.module}/templates/jenkins.yaml.tpl")
  vars = {
    ACCESS_KEY_DEV = aws_iam_access_key.jenkins_dev.id
    SECRET_KEY_DEV = aws_iam_access_key.jenkins_dev.secret

    ACCESS_KEY_DNS = aws_iam_access_key.jenkins_dns.id
    SECRET_KEY_DNS = aws_iam_access_key.jenkins_dns.secret

    subnet_id = var.jenkins_runner_subnet_id
  }
}

resource "local_file" "jenkins_yaml" {
  filename = "${path.cwd}/${path.module}/jenkins.yaml"
  content  = data.template_file.jenkins_yaml.rendered
}

resource "null_resource" "jenkins" {
  depends_on = [
    local_file.jenkins_yaml
  ]
  triggers = {
    build_trigger = var.build_trigger
  }
  provisioner "local-exec" {
    when    = create
    command = <<-EOF
      CREDENTIALS=( $(aws sts assume-role \
        --role-arn "arn:aws:iam::ACCOUNTID:role/G-Admin" \
        --role-session-name terraform \
        --query "[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]" \
        --output text) )
      unset AWS_PROFILE
      unset AWS_SECURITY_TOKEN
      export AWS_DEFAULT_REGION=eu-central-1
      export AWS_ACCESS_KEY_ID=$${CREDENTIALS[0]}
      export AWS_SECRET_ACCESS_KEY=$${CREDENTIALS[1]}
      export AWS_SESSION_TOKEN=$${CREDENTIALS[2]}
      env | grep AWS
      aws sts get-caller-identity
      eval $(aws ecr get-login --no-include-email)
      cd modules/ecs/
      docker build -t ${replace(aws_ecr_repository.jenkins.repository_url, "https://", "")}:latest .
      docker push ${replace(aws_ecr_repository.jenkins.repository_url, "https://", "")}:latest
    EOF
  }
}
