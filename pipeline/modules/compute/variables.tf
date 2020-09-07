variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.small"
}

variable "subnet_id" {
  description = "subnet_id"
  type        = string
}

variable "user_data" {
  description = "user_data"
  type        = string
  default     = "apt update && apt upgrade -y "
}

variable "availability_zone" {
  type        = string
  description = "The AZ to start the instance in."
  default     = "ap-south-1b"
}

variable "ebs_block_device" {
  description = "ebs_block_device"
  type        = list(any)
  default     = []

}

variable "root_block_device" {
  description = "root_block_device"
  type        = list(any)
  default     = []
}


variable "tags" {
  type        = map
  description = "Tags"
  default     = {}
}

variable "ami" {
  description = "ID of AMI to use for the instance"
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"
}

variable "instance_initiated_shutdown_behavior" {
  description = "Shutdown behavior for the instance"
  default     = ""
}

variable "key_name" {
  description = "The key name to use for the instance"
  default     = ""
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false
}

variable "security_groups" {
  description = "A list of security group IDs to associate with"
  type        = list(string)
}


variable "associate_public_ip_address" {
  description = "If true, the EC2 instance will have associated public IP address"
  default     = false
}

