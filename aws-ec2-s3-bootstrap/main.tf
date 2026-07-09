terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "> 6.0.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = ""
  secret_key = ""
}

module "s3" {
  source = "./modules/S3"
}

module "ec2" {
  source = "./modules/ec2"
  bucket_name = module.s3.bucket_name
  bucket_arn = module.s3.bucket_arn
}