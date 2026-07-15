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

module "alb" {
  source = "./modules/ALB"
  instances = {
    red_instance = module.ec2.red_instance,
    blue_instance = module.ec2.blue_instance
  }
}

output "lb_dns" {
  value = module.alb.public_dns
}