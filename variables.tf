variable "name" {}
variable "engine" {
  default = "aurora-mysql"
}
variable "engine_version" {
  default = "8.0.mysql_aurora.3.02.0"
}
variable "auto_minor_version_upgrade" {
  type    = bool
  default = false
}
variable "publicly_accessible" {
  default = "false"
}

variable "vpc_id" {}

variable "subnets" {
  type = list(string)
}
variable "instance_class" {
  type    = string
  default = "db.r5.xlarge"
}

variable "allowed_security_groups" {
  type = list(string)
}

variable "master_username" {}
variable "database_name" {}
variable "tags" {
  type    = map(string)
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {}
variable "route53_record_name" {}

variable "worker_security_group_id" {}
variable "cluster_security_group_id" {}
variable "cluster_primary_security_group_id" {}
variable "apply_immediately" {
  type    = bool
  default = false
}
variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(any)
  default = ["general"]
}
variable "create_db_subnet_group" {
  type    = bool
  default = true
}
variable "create_security_group" {
  type    = bool
  default = true
}

variable "iam_database_authentication_enabled" {
  type    = bool
  default = true
}

variable "snapshot_identifier" {
  default = null
  type = string
  description = "If specified creates this database from a snapshot. Default is null.  Be warned that modifying this value on an already created database _WILL_ destroy/recreate the whole cluster."
}
