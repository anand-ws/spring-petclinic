variable "create_vpc" {
  type        = bool
  default     = false
  description = "create vpc ?"
}

variable "create_subnet" {
  type        = bool
  default     = false
  description = "create subnet ?"
}

variable "create_internet_gateway" {
  type        = bool
  default     = false
  description = "create internet_gateway ?"
}

variable "create_egress_only_igw" {
  type        = bool
  description = "create egress_only_igw ?"
  default     = false
}

variable "create_security_group" {
  type        = bool
  default     = false
  description = "create security_group ?"
}

variable "create_nat_gateway" {
  type        = bool
  default     = false
  description = "create nat_gateway ?"
}

variable "create_eip" {
  type        = bool
  default     = false
  description = "create eip ?"
}

variable "create_route_table" {
  type        = bool
  default     = false
  description = "create route_table ? "
}

variable "create_rt_association" {
  type        = bool
  default     = false
  description = "create rt_association ? "
}

variable "create_route" {
  type        = bool
  default     = false
  description = "create route ? "
}


# ------------------
variable "vpc_cidr_block" {
  description = "vpc_cidr_block"
  type        = string
  default     = ""
}

variable "sg_rules" {
  description = "sg_rules"
  # type        = list(any)
  default = {}
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = ""
}

variable "subnet_cidr" {
  type        = string
  description = "subnet cidr"
  default     = ""
}

variable "availability_zone" {
  type        = string
  description = "The AZ to start the instance in."
  default     = "ap-south-1b"
}

variable "gw_allocation_id" {
  type        = string
  description = "gw_allocation_id"
  default     = ""
}

variable "nat_subnet_id" {
  type        = string
  description = "nat_subnet_id"
  default     = ""
}

variable "eip_instance_id" {
  type        = string
  description = "eip_instance_id"
  default     = ""
}

variable "route" {
  description = "route"
  default     = []
  type        = list(any)
}

variable "subnet_id" {
  description = "subnet_id"
  default     = ""
  type        = string
}

variable "route_table_id" {
  description = "route_table_id"
  default     = ""
  type        = string
}

variable "destination_cidr_block" {
  description = "destination_cidr_block"
  default     = ""
  type        = string
}

variable "nat_gateway_id" {
  description = "nat_gateway_id"
  default     = ""
  type        = string
}


variable "tags" {
  type        = map
  description = "tags"
  default     = {}
}



