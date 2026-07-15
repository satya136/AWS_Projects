terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "> 6.0.0"
    }
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "us-east-1a" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1a"
}

data "aws_subnet" "us-east-1b" {
  vpc_id = data.aws_vpc.default.id
  availability_zone = "us-east-1b"
}

resource "aws_alb" "alb" {
  name = "my-alb"
  load_balancer_type = "application"
  internal = false
  security_groups = [ aws_security_group.alb_sg.id ]
  subnets = [ data.aws_subnet.us-east-1a.id, data.aws_subnet.us-east-1b.id ]
}

output "public_dns" {
  value = aws_alb.alb.dns_name
}