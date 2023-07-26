resource "aws_s3_bucket" "nf-s3-wordpress" {
  bucket = "nf-s3-wordpress"
  
  tags = {
    Name = "nf-s3-wordpress"
  }
}

resource "aws_s3_bucket_acl" "nf-s3-wordpress-acl" {
  bucket = aws_s3_bucket.nf-s3-wordpress.id
  acl    = "private"
}