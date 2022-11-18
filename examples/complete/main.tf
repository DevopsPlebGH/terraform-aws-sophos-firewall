module "complete" {
  source                 = "../.."
  accept_eula            = "yes"
  availability_zone      = "us-west-2c"
  aws_region             = "us-west-2"
  create_vpc             = true
  config_backup_password = "Password!123"
  console_password       = "Password!123"
  instance_size          = "t3.medium"
  name                   = "terraform-aws-sophos-firewall"
  send_stats             = "on"
  sku                    = "payg"
  trusted_ip             = "47.184.79.94/32"
}