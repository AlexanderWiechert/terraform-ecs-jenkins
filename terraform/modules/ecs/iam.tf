data "aws_iam_policy_document" "jenkins" {
  statement {
    sid = "1"

    actions = [
      "*"
    ]

    resources = [
      "*",
    ]
  }
}

### DEV ###
resource "aws_iam_user" "jenkins_dev" {
  name = "jenkins_mb"
  lifecycle {
    prevent_destroy = "true"
  }
}

resource "aws_iam_user_policy" "jenkins_dev" {
  policy = data.aws_iam_policy_document.jenkins.json
  user   = aws_iam_user.jenkins_dev.name
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

 resource "aws_iam_user_policy" "jenkins_qa" {
   policy   = data.aws_iam_policy_document.jenkins.json
   user     = aws_iam_user.jenkins_qa.name
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

resource "aws_iam_user_policy" "jenkins_dns" {
  policy   = data.aws_iam_policy_document.jenkins.json
  user     = aws_iam_user.jenkins_dns.name
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
