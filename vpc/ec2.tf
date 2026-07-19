data "aws_ami" "ami" {
  region = var.region
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-2023*"]
  }
}

resource "aws_instance" "ec2" {
  for_each = toset(var.sg_names)
  vpc_security_group_ids = [ aws_security_group.sg[each.value].id]
  ami = data.aws_ami.ami.id
  instance_type = "t3.micro"
  user_data = file("./user_data.sh")
  subnet_id = aws_subnet.subnets[var.sg_to_subnet[each.key]].id
  associate_public_ip_address = true
  key_name = aws_key_pair.ssh_key.key_name

  tags = {
    Name = "${each.value}-instance"
  }
}

output "public_dns" {
  value = {
    for key, instance in aws_instance.ec2 : key => instance.public_dns
  }
}