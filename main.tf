provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "development" {
  bucket = "neufische-aws-cohort-deham6-dev"

  tags = {
    Name        = "neufische-aws-cohort-deham6"
    Environment = "development"
  }
}
/*
resource "aws_s3_bucket" "production" {
  bucket = "neufische-aws-cohort-deham6-prod"

  tags = {
    Name        = "neufische-aws-cohort-deham6"
    Environment = "production"
  }
}

resource "aws_instance" "deham6demos1"{
    ami = "ami-012e877411b53f3bd"
    instance_type = "t2.micro"
    key_name = "deham630062023"
    vpc_security_group_ids = ["sg-0668745a1e96b9e55"]
    subnet_id = "subnet-05527afe89ba4d0ee"

    tags = {
        Name = "neufische-aws-cohort-deham6"
    }
}
*/
