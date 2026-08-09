resource "aws_db_subnet_group" "db_subnet" {
  name = "photoshare-db-group"
  subnet_ids = var.private_subnet_ids
  tags = {
    Name = "photoshare-db-group"
  }
}

resource "aws_security_group" "db-sg" {
  name = "db-sg"
  vpc_id = var.vpc_id
  description = "To allow inbound TCP on port 3306"
  tags = {
    Name = "db=sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tcp" {
  ip_protocol = "tcp"
  security_group_id = aws_security_group.db-sg.id
  from_port = var.db_port
  to_port = var.db_port
  cidr_ipv4 = var.vpc_cidr
}

resource "aws_vpc_security_group_egress_rule" "outbound" {
  ip_protocol = "-1"
  security_group_id = aws_security_group.db-sg.id
  cidr_ipv4 = "0.0.0.0/0"
}

resource "random_password" "db_pass" {
  length = 15
  special = false
}

resource "aws_db_instance" "db" {
  instance_class = var.db_instance
  allocated_storage = var.db_storage
  storage_type = var.db_storage_type
  identifier = var.db_instance_identifier
  engine = var.db_engine
  engine_version = var.db_engine_version
  db_name = var.db_name
  port = var.db_port
  username = var.username
  password = random_password.db_pass.result
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name
  publicly_accessible = false
  apply_immediately = true
  skip_final_snapshot = true
}