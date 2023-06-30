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

resource "aws_s3_bucket" "dryrun" {
  bucket = "neufische-dryrun-bucket"

  tags = {
    Name        = "neufische-dryrun-bucket"
    Environment = "QA"
  }
}

# Instance Configuration
resource "aws_instance" "deham6ec2"{
    ami = "ami-0fa167c2af1ea0840"
    instance_type = "t3.micro"
    key_name = "deham630062023"
    vpc_security_group_ids = ["sg-0668745a1e96b9e55"]
    subnet_id = "subnet-05527afe89ba4d0ee"

    tags = {
        Name = "deham6ec2"
    }
}
