variable "name" {
  type = string
}

variable "engine" {
  default = "aurora-mysql"
  type    = string
}

variable "engine_version" {
  default = "8.0"
  type    = string
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "publicly_accessible" {
  default = "false"
  type    = string
}

variable "vpc_id" {
  type = string
}

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

variable "master_username" {
  type = string
}

variable "database_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {
  type = string
}

variable "route53_record_name" {
  type = string
}

variable "worker_security_group_id" {
  type = string
}
variable "cluster_security_group_id" {
  type = string
}
variable "cluster_primary_security_group_id" {
  type = string
}
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
  default = ["audit", "error", "general", "slowquery"]
}
variable "create_db_subnet_group" {
  type    = bool
  default = true
}
variable "create_security_group" {
  type    = bool
  default = true
}

variable "security_group_allowed_cidrs" {
  type    = list(string)
  default = []
}

variable "iam_database_authentication_enabled" {
  type    = bool
  default = true
}

variable "snapshot_identifier" {
  default     = null
  type        = string
  description = "If specified creates this database from a snapshot. Default is null.  Be warned that modifying this value on an already created database _WILL_ destroy/recreate the whole cluster."
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Default `7`"
  type        = number
  default     = 35
}

variable "db_parameter_group_parameters" {
  type = list(map(string))

  default = [{
    name  = "general_log"
    value = "1"
    }, {
    name  = "group_concat_max_len"
    value = "4096"
    }, {
    name  = "log_bin_trust_function_creators"
    value = "1"
    }, {
    name  = "max_allowed_packet"
    value = "1073741824"
    }, {
    name  = "transaction_isolation"
    value = "READ-COMMITTED"
    }
  ]
}

variable "db_cluster_parameter_group_parameters" {
  type = list(map(string))

  default = [
    #     {
    #       name  = "default_password_lifetime"
    #       value = "60"
    #     },
    {
      name  = "group_concat_max_len"
      value = "4096"
    }
  ]
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-rsa2048-g1"
}
