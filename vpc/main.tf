terraform {
  required_providers {
    aws = {
        version = ">6.0.0"
        source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "test_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "test_vpc"
  }
}

resource "aws_subnet" "subnets" {
  for_each = var.subnet_cidr
  vpc_id = aws_vpc.test_vpc.id
  cidr_block = each.value
  availability_zone = var.subnet_names[index(keys(var.subnet_cidr), each.key) % length(var.subnet_names)]
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "test_igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = var.sg_cidr
    gateway_id = aws_internet_gateway.test_igw.id  
  }

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route_table_association" "rt_attach" {
  for_each = toset(var.sg_names)
  route_table_id = aws_route_table.public_rt.id
  subnet_id = aws_subnet.subnets[var.sg_to_subnet[each.key]].id
}
