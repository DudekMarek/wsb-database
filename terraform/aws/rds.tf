resource "aws_security_group" "merito_rds" {
  name = "merito-rds"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "merito_mdudek" {
  identifier             = "merito-mdudek"
  instance_class         = "db.t3.micro"
  engine                 = "postgres"
  engine_version         = "15.5"
  username               = "mdudek"
  password               = var.rds_password
  vpc_security_group_ids = [aws_security_group.merito_rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = true
  allocated_storage      = 20
  max_allocated_storage  = 20
}