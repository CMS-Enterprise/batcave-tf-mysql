terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.61.0"
    }
  }
  required_version = ">= 1.2"
}

module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "6.1.4"

  name                       = var.name
  engine                     = var.engine
  engine_version             = var.engine_version
  auto_minor_version_upgrade = var.auto_minor_version_upgrade
  instances = {
    1 = {
      instance_class      = var.instance_class
      publicly_accessible = var.publicly_accessible
    }
  }

  vpc_id                  = var.vpc_id
  subnets                 = var.subnets
  create_db_subnet_group  = var.create_db_subnet_group
  create_security_group   = var.create_security_group
  allowed_security_groups = var.allowed_security_groups
  security_group_egress_rules = {
    to_cidrs = {
      cidr_blocks = var.security_group_egress_rules_cidr_blocks
      description = var.security_group_egress_rules_cidr_blocks_description
    }
  }
  allowed_cidr_blocks = var.security_group_allowed_cidrs

  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  master_username                     = var.master_username
  create_random_password              = true
  database_name                       = var.database_name
  ca_cert_identifier                  = var.ca_cert_identifier

  apply_immediately   = var.apply_immediately
  skip_final_snapshot = var.skip_final_snapshot
  snapshot_identifier = var.snapshot_identifier

  db_parameter_group_name         = aws_db_parameter_group.db_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.db_cluster_parameter_group.id
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags                    = var.tags
  copy_tags_to_snapshot   = true
  backup_retention_period = var.backup_retention_period
}

resource "aws_db_parameter_group" "db_parameter_group" {
  name        = "${var.name}-aurora-db-mysql-parameter-group"
  family      = var.db_parameter_group_family
  description = "${var.name}-aurora-db-mysql-parameter-group"
  tags        = var.tags
  dynamic "parameter" {
    for_each = var.db_parameter_group_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }
}


resource "aws_rds_cluster_parameter_group" "db_cluster_parameter_group" {
  name        = "${var.name}-aurora-mysql-cluster-parameter-group"
  family      = var.db_cluster_parameter_group_family
  description = "${var.name}-aurora-mysql-cluster-parameter-group"
  tags        = var.tags
  dynamic "parameter" {
    for_each = var.db_cluster_parameter_group_parameters
    content {
      name  = parameter.value["name"]
      value = parameter.value["value"]
    }
  }
}
