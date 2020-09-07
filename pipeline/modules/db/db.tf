resource "aws_db_instance" "db_instance" {
  allocated_storage     = var.db_storage
  max_allocated_storage = var.db_max_storage
  db_subnet_group_name  = var.db_subnet_group_name
  storage_type          = var.db_storage_type
  engine                = var.db_engine
  engine_version        = var.db_engine_version
  instance_class        = var.db_instance_class
  name                  = var.db_name
  username              = var.db_username
  password              = var.db_password
  parameter_group_name  = var.db_parameter_group
}
