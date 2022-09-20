module "key-pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  version            = "2.0.0"
  key_name           = "sophos"
  create_private_key = true
}

module "complete" {
  source                    = "../../"
  create_vpc                = true
  console_password          = var.console_password
  ssh_key_name              = module.key-pair.key_pair_name
  secure_storage_master_key = var.secure_storage_master_key
  config_backup_password    = var.config_backup_password
}

