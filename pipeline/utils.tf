
module "sns" {
  source           = "./modules/sns/"
  create_sns_topic = true
  sns_topic_name   = "installation_update"
  tags             = merge(local.tags, { "Name" = "installation_update" })
}
