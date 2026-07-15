resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  description = "SG for ALB"

  tags = {
    Name = "alb-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_in" {
  from_port = 80
  to_port = 80
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "tcp"
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_vpc_security_group_egress_rule" "allow_out" {
  from_port = -1
  to_port = -1
  ip_protocol = -1
  cidr_ipv4 = "0.0.0.0/0"
  security_group_id = aws_security_group.alb_sg.id
}
