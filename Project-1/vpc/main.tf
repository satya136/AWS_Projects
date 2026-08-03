resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "photoshare-vpc"
  }
}

locals {
  public_subnets = {
    for i, subnet_cidr in var.public_subnets_cidr :
    var.zones[i] => {
      cidr = subnet_cidr,
      az   = var.zones[i]
    }
  }

  private_subnets = {
    for i, subnet_cidr in var.private_subnets_cidr :
    var.zones[i] => {
      cidr = subnet_cidr,
      az   = var.zones[i]
    }
  }
}

resource "aws_subnet" "public_subnets" {
  for_each          = local.public_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "Public-subnet-${each.key}"
  }

}

resource "aws_subnet" "private_subnets" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = each.value.cidr
  availability_zone = each.value.az

  tags = {
    Name = "Private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "photoshare-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block           = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_rt_add" {
  for_each       = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = each.value.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_route_table_association" "private_rt_add" {
  for_each       = aws_subnet.private_subnets
  route_table_id = aws_route_table.private_rt.id
  subnet_id      = each.value.id
} 