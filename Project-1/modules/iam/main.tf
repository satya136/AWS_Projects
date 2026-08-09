resource "aws_iam_role" "iam_role_ec2" {
  name = "iam_role_ec2"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]})
#   tags = {
#     Name = "iam_role_ec2"
#   }
}

resource "aws_iam_role" "iam_role_lambda" {
  name = "iam_role_lambda"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "lambda.amazonaws.com"
                ]
            }
        }
    ]})
    # tags = {
    #   Name = "iam_role_lambda"
    # }
}

resource "aws_iam_role_policy_attachment" "ec2_attach_policy" {
  for_each = toset(var.ec2_policies)
  role = aws_iam_role.iam_role_ec2.id
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}

resource "aws_iam_role_policy_attachment" "lambda_attach_policy" {
  for_each = toset(var.lambda_policies)
  role = aws_iam_role.iam_role_lambda.id
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
}