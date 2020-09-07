resource "aws_ecs_cluster" "ecs_cluster" {
  name               = var.cluster_name
  capacity_providers = var.capacity_providers
  tags               = var.tags

  dynamic "setting" {
    for_each = var.setting
    content {
      name  = lookup(setting.value, "name")
      value = lookup(setting.value, "value")
    }
  }
}
resource "aws_ecs_task_definition" "ecs_task_def" {
  family                = "service"
  container_definitions = var.container_definitions

  volume {
    name      = "service-storage"
    host_path = "/ecs/service-storage"
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}


resource "aws_ecs_service" "ecs_service" {
  name            = var.app_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task_def.arn
  desired_count   = 1
  iam_role        = aws_iam_role.role.arn
  depends_on      = [aws_iam_role_policy.policy]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.lb_tg.arn
    container_name   = var.app_name
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}

# ---------

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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  user_data     = var.user_data
  # ebs_block_device = var.ebs_block_device
  tags = {
    Name = "HelloWorld"
  }
}


# variable "app_name" {
#   type        = string
#   description = "describe your variable"
#   default     = "default_value"
# }

# variable "cluster_name" {
#   type        = string
#   description = "cluster_name"
# }

# variable "capacity_providers" {
#   type        = string
#   description = "capacity_providers"
# }

# variable "tags" {
#   type        = map
#   description = "tags"
# }

# variable "setting" {
#   type        = map
#   description = "setting"
# }
