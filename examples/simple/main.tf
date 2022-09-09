module "key-pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "2.0.0"
  key_name           = "sophos"
  create_private_key = true
}

module "example-basic" {
  source                    = "../../"
  create_vpc                = true
  admin_password            = var.password
  region                    = "us-west-2"
  secure_storage_master_key = var.password
  config_password           = var.password
  central_username          = "ralph.brynard2@sophos.com"
  central_password          = var.central_password
  key_name           = module.key-pair.key_pair_name
}

