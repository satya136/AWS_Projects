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
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "test-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.region}-bucket"
}

resource "aws_s3_bucket_public_access_block" "block_public" {
    bucket = aws_s3_bucket.s3_bucket.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_s3_object" "objects" {
  for_each = fileset("${path.module}/data","*")
  bucket = aws_s3_bucket.s3_bucket.id
  key = each.value
  source = "${path.module}/data/${each.value}"
}