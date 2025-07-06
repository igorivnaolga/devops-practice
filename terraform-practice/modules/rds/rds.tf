resource "aws_db_subnet_group" "main" {
  name       = "${var.db_name}-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "postgres" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
#  vpc_security_group_ids = [var.db_sg]
  db_subnet_group_name   = aws_db_subnet_group.main.name
  skip_final_snapshot = true

  depends_on = [aws_db_subnet_group.main]
}