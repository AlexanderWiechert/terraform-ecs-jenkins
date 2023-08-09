resource "aws_vpc" "jenkins_runner" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = var.baseTags
}

resource "aws_internet_gateway" "jenkins_runner" {
  vpc_id = aws_vpc.jenkins_runner.id
  tags   = var.baseTags
}

resource "aws_subnet" "jenkins_runner" {
  cidr_block = "10.0.3.0/24"
  vpc_id = aws_vpc.jenkins_runner.id
  availability_zone = "eu-central-1a"
  map_public_ip_on_launch = true
  tags = merge(var.baseTags, {
    Name: "jenkins_runner"
  })
}

resource "aws_route_table" "jenkins_runner" {
  vpc_id = aws_vpc.jenkins_runner.id
  tags = var.baseTags
}

resource "aws_route_table_association" "jenkins_runner" {
  route_table_id = aws_route_table.jenkins_runner.id
  subnet_id      = aws_subnet.jenkins_runner.id
}

resource "aws_route" "jenkins_runner" {
  route_table_id         = aws_route_table.jenkins_runner.id
  gateway_id             = aws_internet_gateway.jenkins_runner.id
  destination_cidr_block = "0.0.0.0/0"
}
