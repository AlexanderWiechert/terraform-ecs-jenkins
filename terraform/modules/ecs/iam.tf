resource "aws_iam_group_policy" "jenkins" {
  name  = "jenkins"
  group = aws_iam_group.jenkins.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:**",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecs:**",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "ecr:**",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "jenkins" {
  group      = aws_iam_group.jenkins.name
  policy_arn = aws_iam_group_policy.jenkins.arn
}
### DEV ###

resource "aws_iam_group" "jenkins" {
  name = "jenkins"
}

resource "aws_iam_group_membership" "jenkins" {
  name = "jenkins"

  users = [
    aws_iam_user.jenkins_dev.name,
    aws_iam_user.jenkins_qa.name,
    aws_iam_user.jenkins_dns.name,
  ]

  group = aws_iam_group.jenkins.name
}



### DEV ###

resource "aws_iam_user" "jenkins_dev" {
  name = "jenkins_mb"
  lifecycle {
    prevent_destroy = "true"
  }
}

resource "aws_iam_access_key" "jenkins_dev" {
  user = aws_iam_user.jenkins_dev.name
  lifecycle {
    prevent_destroy = "true"
  }
}
### ###

### QA ###
 resource "aws_iam_user" "jenkins_qa" {
   name     = "jenkins_mb"
   provider = aws.aws_qa
   lifecycle {
     prevent_destroy = "true"
   }
 }

 resource "aws_iam_access_key" "jenkins_qa" {
   user     = aws_iam_user.jenkins_qa.name
   provider = aws.aws_qa
   lifecycle {
     prevent_destroy = "true"
   }
 }
### ###

### DNS ###
resource "aws_iam_user" "jenkins_dns" {
  name     = "jenkins_mb"
  provider = aws.aws_dns
  lifecycle {
    prevent_destroy = "true"
  }
}

resource "aws_iam_access_key" "jenkins_dns" {
  user     = aws_iam_user.jenkins_dns.name
  provider = aws.aws_dns
  lifecycle {
    prevent_destroy = "true"
  }
}
### ###
