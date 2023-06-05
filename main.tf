provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_s3_bucket" "example" {
  bucket = "neufische-sample-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
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