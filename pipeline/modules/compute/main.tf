resource "aws_instance" "instance" {
  ami                                  = var.ami
  instance_type                        = var.instance_type
  subnet_id                            = var.subnet_id
  user_data                            = var.user_data
  availability_zone                    = var.availability_zone
  iam_instance_profile                 = aws_iam_instance_profile.vm_profile.id
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  vpc_security_group_ids               = var.security_groups
  associate_public_ip_address          = var.associate_public_ip_address
  instance_initiated_shutdown_behavior = var.instance_initiated_shutdown_behavior
  tenancy                              = var.tenancy
  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      device_name = lookup(root_block_device.value, "device_name")
      volume_size = lookup(root_block_device.value, "volume_size")
    }
  }


  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name = lookup(ebs_block_device.value, "device_name")
      volume_size = lookup(ebs_block_device.value, "volume_size")
    }
  }
  tags = var.tags
}


# resource "aws_ebs_volume" "example" {
#   availability_zone = var.availability_zone
#   size              = var.ebs_size
#   tags              = var.tags
# }


resource "aws_iam_instance_profile" "vm_profile" {
  name = var.tags.Name
  role = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name = var.tags.Name
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
