resource "aws_s3_bucket" "nf_s3_wordpress" {
  bucket = "nf_s3_wordpress"
  
  tags = {
    Name = "nf_s3_wordpress"
  }
}

resource "aws_s3_bucket_acl" "nf_s3_wordpress_acl" {
  bucket = aws_s3_bucket.nf_s3_wordpress.id
  acl    = "private"
}