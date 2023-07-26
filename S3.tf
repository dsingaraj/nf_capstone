resource "aws_s3_bucket" "nf-s3-wordpress" {
  bucket = "nf_s3_wordpress"
  
  tags = {
    Name = "nf_s3_wordpress"
  }
}

resource "aws_s3_bucket_acl" "nf-s3-wordpress-acl" {
  bucket = aws_s3_bucket.nf_s3_wordpress.id
  acl    = "private"
}