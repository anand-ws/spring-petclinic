variable "region" {
  type        = string
  description = "AWS region"
  default     = "ap-south-1"
}

variable "app_name" {
  type    = string
  default = "petclinic"
}

variable "app_env" {
  type    = string
  default = "dev"
}

variable "vpc_cidr_block" {
  type        = string
  description = "describe your variable"
  default     = "10.0.0.0/22"
}


# 10.0.1.0/24  
# 10.0.2.0/24
# 10.0.3.0/24
# 10.0.4.0/24
