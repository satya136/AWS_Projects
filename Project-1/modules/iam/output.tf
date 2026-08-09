output "ec2_role_id" {
  value = aws_iam_role.iam_role_ec2.id
}

output "ec2_role_arn" {
  value = aws_iam_role.iam_role_ec2.arn
}

output "lambda_role_id" {
  value = aws_iam_role.iam_role_lambda.id
}

output "lambda_role_arn" {
  value = aws_iam_role.iam_role_lambda.arn
}