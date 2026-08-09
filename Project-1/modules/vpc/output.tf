output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnets" {
  value = values(aws_subnet.private_subnets)[*].id
}

output "public_subnets" {
  value = values(aws_subnet.public_subnets)[*].id
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}