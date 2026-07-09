terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "> 6.0.0"
    }
  }
}

data "aws_ami" "get_ami" {
    region = var.region
    owners = [ "amazon" ]
    most_recent = true
    filter {
      name = "name"
      values = ["al2023-ami-2023*"]
    }
}
resource "aws_instance" "myec2" {
  for_each = var.names
  ami = data.aws_ami.get_ami.id
  instance_type = lookup(var.instance_type,var.env)
  vpc_security_group_ids = [aws_security_group.myec2-sg[each.key].id]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  user_data = templatefile("${path.module}/user-data-${each.value}.sh",{
    bucket_name = var.bucket_name
  })
  tags = {
    Name = "my-ec2-from-tf"
  }
}