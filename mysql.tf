resource "aws_db_instance" "nf-mysql-db" {
  allocated_storage    = 20
  db_name              = local.DB
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = local.User
  password             = local.PW
  skip_final_snapshot  = true
  db_subnet_group_name  = aws_db_subnet_group.subnet-group.name
  vpc_security_group_ids = [aws_security_group.nf-mysqldb-sg.id]
}
resource "aws_db_subnet_group" "subnet-group" {
  name       = "my-subnet-group"
  subnet_ids = [aws_subnet.nf_privatesubnet1.id, aws_subnet.nf_privatesubnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}