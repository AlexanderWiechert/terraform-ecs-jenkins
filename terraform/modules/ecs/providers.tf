provider "aws" {
  region = var.region
  alias  = "aws_dns"
  assume_role {
    role_arn = "arn:aws:iam::ACCOUNTID:role/Admin"
  }
}
