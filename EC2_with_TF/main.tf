terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 6.0.0"
    }
  }
}

provider "aws" {
  region     = var.region
}

data "aws_ami" "get_details" {
  region      = var.region
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "myec2" {
  ami                         = data.aws_ami.get_details.id
  instance_type               = lookup(var.instance_type, var.env)
  vpc_security_group_ids      = [aws_security_group.my-sg.id]
  user_data                   = file("./user-data.sh")
  associate_public_ip_address = true


  tags = {
    Name = "my-ec2-from-terraform"
  }
}

resource "aws_security_group" "my-sg" {
  name        = "my-ec2-sg"
  description = "Allow SSH and http access"

}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  from_port         = var.http_port
  to_port           = var.http_port
  ip_protocol       = "tcp"
  security_group_id = aws_security_group.my-sg.id
  cidr_ipv4         = var.cidr
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my-sg.id
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  ip_protocol       = "tcp"
  cidr_ipv4         = var.cidr
}

output "public_ip" {
  value = aws_instance.myec2.public_ip
}