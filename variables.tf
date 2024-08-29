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

variable "create_reader_instance" {
  description = "Whether to create a read replica instance"
  type        = bool
  default     = false
}

variable "reader_instance_class" {
  description = "Instance class for the read replica"
  type        = string
  default     = "db.r5.large"
}

variable "publicly_accessible_replica" {
  description = "Whether the replica instance should be publicly accessible"
  type        = bool
  default     = false
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

variable "security_group_egress_rules_cidr_blocks" {
  description = "egress cidr blocks"
  type        = list(any)
  default     = ["0.0.0.0/0"]

}

variable "security_group_egress_rules_cidr_blocks_description" {
  description = "egress cidr blocks description"
  type        = string
  default     = "Egress to Internet"
}

variable "db_parameter_group_family" {
  description = "db parameter group family"
  type        = string
  default     = "aurora-mysql8.0"
}

variable "db_cluster_parameter_group_family" {
  description = "db parameter group family"
  type        = string
  default     = "aurora-mysql8.0"
}

variable "performance_insights_enabled" {
  description = "Enable performance insights"
  type        = bool
  default     = true
}

variable "performance_insights_retention_period" {
  description = "Performance insights retention period"
  type        = number
  default     = 7
}

variable "create_monitoring_role" {
  description = "Create monitoring role"
  type        = bool
  default     = true
}

variable "iam_role_path" {
  description = "IAM role path"
  type        = string
  default     = ""
}

variable "iam_role_permissions_boundary" {
  description = "IAM role permissions boundary"
  type        = string
  default     = ""
}
