variable "ec2_policies" {
    default = ["AmazonS3FullAccess","AWSSecretsManagerClientReadOnlyAccess"]
}

variable "lambda_policies" {
    default = ["AmazonS3FullAccess","service-role/AWSLambdaBasicExecutionRole"]
}