variable "app_name" {
  type        = string
  description = "describe your variable"
  default     = "default_value"
}

variable "cluster_name" {
  type        = string
  description = "cluster_name"
}

variable "capacity_providers" {
  type        = list
  description = "capacity_providers"
}

variable "tags" {
  type        = map
  description = "tags"
}


variable "setting" {
  type        = list(any)
  description = "ECS setting"
}

variable "container_definitions" {
  type        = string
  description = "container definitions"
}

variable "target_port" {
  type        = string
  description = "target port"
}

variable "target_protocol" {
  type        = string
  description = "target protocol"
}


variable "listener_port" {
  type        = string
  description = "listener port"
}

variable "listener_protocol" {
  type        = string
  description = "listener protocol"
}

variable "certificate_arn" {
  type        = string
  description = "certificate arn"

}



variable "db_storage" {
  type        = string
  description = "db_storage"
}

variable "db_max_storage" {
  type        = string
  description = "db_max_storage"
}

variable "db_subnet_group_name" {
  type        = string
  description = "db_subnet_group_name"
}

variable "db_storage_type" {
  type        = string
  description = "db_storage_type"
}

variable "db_engine" {
  type        = string
  description = "db_engine"
}

variable "db_engine_version" {
  type        = string
  description = "db_engine_version"
}

variable "db_instance_class" {
  type        = string
  description = "db_instance_class"
}

variable "db_name" {
  type        = string
  description = "db_name"
}

variable "db_username" {
  type        = string
  description = "db_username"
}

variable "db_password" {
  type        = string
  description = "db_password"
}

variable "db_parameter_group" {
  type        = string
  description = "db_parameter_group"
}


variable "instance_type" {
  description = "instance_type"
  type        = string
}

variable "subnet_id" {
  description = "subnet_id"
  type        = string
}

variable "user_data" {
  description = "user_data"
  type        = string
}

variable "ebs_block_device" {
  description = "ebs_block_device"
  type        = string
}



variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  type        = string
}
variable "sg_rules" {
  description = "sg_rules"
  type        = list(any)
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "default_value"
}

variable "subnet_cidr" {
  type        = string
  description = "subnet cidr"
  default     = "default_value"
}


variable "lb_security_groups" {
  type        = list
  description = "lb security_groups"
}

variable "lb_subnets" {
  type        = list
  description = "lb subnets"
}

variable "lb_access_logs_bucket" {
  type        = string
  description = "lb access_logs_bucket"
}

variable "gw_allocation_id" {
  type        = string
  description = "gw_allocation_id"
}

variable "nat_subnet_id" {
  type        = string
  description = "nat_subnet_id"
}

variable "eip_instance_id" {
  type        = string
  description = "eip_instance_id"
}



variable "role_id" {
  type        = string
  description = "describe your variable"
  default     = "default_value"
}
