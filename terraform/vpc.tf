locals {
  public_subnets = {
    "${var.region}a" = "10.10.101.0/24"
    "${var.region}b" = "10.10.102.0/24"
    "${var.region}c" = "10.10.103.0/24"
  }
}

resource "aws_vpc" "jenkins" {
  cidr_block           = "10.10.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_subnet" "jenkins" {
  count                   = length(local.public_subnets)
  cidr_block              = element(values(local.public_subnets), count.index)
  vpc_id                  = aws_vpc.jenkins.id
  availability_zone       = element(keys(local.public_subnets), count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_route_table" "external" {
  vpc_id = aws_vpc.jenkins.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins.id
  }

  tags = {
    Name = var.ecs_cluster_name
  }
}

resource "aws_route_table_association" "jenkins" {
  count          = length(local.public_subnets)
  subnet_id      = element(aws_subnet.jenkins.*.id, count.index)
  route_table_id = aws_route_table.external.id
}

resource "aws_internet_gateway" "jenkins" {
  vpc_id = aws_vpc.jenkins.id

  tags = {
    Name = var.ecs_cluster_name
  }
}
