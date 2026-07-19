resource "aws_security_group" "sg" {
  for_each = toset(var.sg_names)
  name = each.value
  description = "security group ${each.value}"
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = each.value
  }
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  for_each = toset(var.sg_names)
  security_group_id = aws_security_group.sg["${each.value}"].id
  ip_protocol = "tcp"
  to_port = lookup(var.ports,"http_port")
  from_port = lookup(var.ports,"http_port")
  cidr_ipv4 = var.sg_cidr
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  for_each = toset(var.sg_names)
  security_group_id = aws_security_group.sg["${each.value}"].id
  ip_protocol = "tcp"
  from_port = lookup(var.ports,"ssh_port")
  to_port = lookup(var.ports,"ssh_port")
  cidr_ipv4 = var.sg_cidr
}
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  for_each = toset(var.sg_names)
  security_group_id = aws_security_group.sg["${each.value}"].id
  ip_protocol = -1
  from_port = 0
  to_port = 0
  cidr_ipv4 = var.sg_cidr
}

resource "aws_vpc_security_group_ingress_rule" "icmp_b" {
  security_group_id = aws_security_group.sg["SG_B"].id
  ip_protocol = "icmp"
  from_port = 0
  to_port = 0
  referenced_security_group_id = aws_security_group.sg["SG_A"].id
}

resource "aws_vpc_security_group_ingress_rule" "icmp_a" {
  security_group_id = aws_security_group.sg["SG_A"].id
  ip_protocol = "icmp"
  from_port = 0
  to_port = 0
  referenced_security_group_id = aws_security_group.sg["SG_B"].id
}