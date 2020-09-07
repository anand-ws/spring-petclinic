provider "aws" {
  region = var.region
}

locals {
  tags = {
    Name = var.app_name
    env  = var.app_env
  }
}
