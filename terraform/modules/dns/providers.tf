provider "aws" {
  alias  = "dns_zone_holder_account"
  region = var.region
  assume_role {
    role_arn = "arn:aws:iam::ACCOUNTID:role/Admin"
  }
}
