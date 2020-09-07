data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}



module "jenkinsVM" {
  source                      = "./modules/compute"
  ami                         = data.aws_ami.ubuntu.id
  subnet_id                   = module.public_subnet_1a.subnet_id[0]
  associate_public_ip_address = true
  key_name                    = "anand-apac"
  security_groups             = module.jenkinsSG.security_group_id
  user_data                   = file("./utils/jenkins.sh")
  tags                        = merge(local.tags, { "Name" = "jenkinsVM" })
  availability_zone           = "ap-south-1a"
  # root_block_device = [{
  #   device_name = "/dev/sdb"
  #   volume_size = 5
  # }]

  ebs_block_device = [{
    device_name = "/dev/sdc"
    volume_size = 5
  }]
}

