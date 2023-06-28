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

resource "aws_s3_bucket" "staging" {
  bucket = "neufische-staging-bucket"

  tags = {
    Name        = "neufische-staging-bucket"
    Environment = "QA"
  }
}

resource "aws_s3_bucket" "pre-prod" {
  bucket = "neufische-pre-prod-bucket"

  tags = {
    Name        = "neufische-qa-bucket"
    Environment = "QA"
  }
}

resource "aws_s3_bucket" "prod" {
  bucket = "neufische-prod-bucket"

  tags = {
    Name        = "neufische-qa-bucket"
    Environment = "QA"
  }
}
