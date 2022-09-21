locals {
  availability_zone_map = {
    for zone in data.aws_availability_zone.available :
    zone.name => zone.zone_id
  }
}

module "key-pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  version            = "2.0.0"
  key_name           = "sophos"
  create_private_key = true
}

module "complete" {
  source                    = "../../"
  create_vpc                = true
  aws_region                = data.aws_region.current.name
  availability_zone         = null
  console_password          = var.console_password
  firewall_hostname         = "sophos-xg-terraform"
  ssh_key_name              = module.key-pair.key_pair_name
  secure_storage_master_key = var.secure_storage_master_key
  config_backup_password    = var.config_backup_password
  send_stats                = "on"
  instance_size             = "t3.medium"
  eula                      = "yes"
  trusted_ip                = var.trusted_ip
  sku                       = "payg"
}

