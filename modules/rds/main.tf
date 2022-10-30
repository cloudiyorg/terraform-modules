resource "aws_db_subnet_group" "private_subnets" {
  name       = "private-db-subnet"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name        = "Project DB Private Subnet Group"
    Project     = "Project"
    Environment = var.env
  }
}

resource "aws_db_subnet_group" "public_subnets" {
  name       = "public-db-subnet"
  subnet_ids = var.public_subnet_ids

  tags = {
    Name        = "Project DB Public Subnet Group"
    Project     = "Project"
    Environment = var.env
  }
}

resource "aws_db_instance" "project_db_instance" {
  depends_on                    = [aws_db_subnet_group.public_subnets]
  storage_type                  = var.db_storage_type
  allocated_storage             = var.db_allocated_storage
  db_subnet_group_name          = aws_db_subnet_group.private_subnets.name
  engine                        = var.db_engine
  engine_version                = var.db_engine_version
  identifier                    = var.db_name
  instance_class                = var.db_instance_type
  username                      = var.username
  password                      = var.password
  publicly_accessible           = var.db_publicly_accessible
  multi_az                      = var.db_multi_az
  skip_final_snapshot           = var.db_skip_final_snapshot
  apply_immediately             = var.db_apply_immediately
  allow_major_version_upgrade   = var.db_allow_major_version_upgrade

  # Performance Insights
  performance_insights_enabled          = var.db_performance_insights_enabled
  performance_insights_retention_period = var.db_performance_insights_retention_period

  # Snapshot
  final_snapshot_identifier = var.db_final_snapshot_identifier
  snapshot_identifier       = var.db_snapshot_identifier
  backup_retention_period   = var.db_backup_retention_period

  # Maintenance Window
  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window
  enabled_cloudwatch_logs_exports = var.db_enabled_cloudwatch_logs_exports

  # Database Deletion Protection
  deletion_protection = var.db_deletion_protection

  tags = {
    Name         = "Project DB"
    Project      = "Project"
    Environment  = var.env
  }
}