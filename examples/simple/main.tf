module "xg" {
  source                    = "../../"
  admin_password            = "password123"
  region                    = "us-west-2"
  secure_storage_master_key = "password123"
  config_password           = "password123"
}
