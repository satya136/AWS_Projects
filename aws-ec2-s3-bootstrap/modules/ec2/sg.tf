resource "aws_security_group" "myec2-sg" {
  for_each = var.names
  name = "myec2-sg-${each.value}"
  description = "SG for EC2-${each.value}"

  tags = {
    Name = "myec2-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  for_each = var.names
  from_port = var.http_port
  to_port = var.http_port
  security_group_id = aws_security_group.myec2-sg[each.key].id
  ip_protocol = "tcp"
  cidr_ipv4 = var.cidr
  description = "Allowing http from internet"
}

resource "aws_vpc_security_group_egress_rule" "all_ipv4" {
  for_each = var.names
  from_port = 0
  to_port = 0
  ip_protocol = -1
  security_group_id = aws_security_group.myec2-sg[each.key].id
  cidr_ipv4 = var.cidr
  description = "allowing all out"
}