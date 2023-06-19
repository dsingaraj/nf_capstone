provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "dev" {
  bucket = "neufische-dev-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "qa" {
  bucket = "neufische-qa-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "prod" {
  bucket = "neufische-prod-bucket"

  tags = {
    Name        = "neufische-qa-bucket"
    Environment = "QA"
  }
}