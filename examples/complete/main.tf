locals {
  aws_region        = data.aws_region.current.name
  availability_zone = element(random_shuffle.az.result, 0)
}

resource "random_shuffle" "az" {
  input        = try(data.aws_availability_zones.available.names[*])
  result_count = 1
}
module "complete" {
  source                 = "../.."
  accept_eula            = "yes"
  availability_zone      = local.availability_zone
  aws_region             = local.aws_region
  create_vpc             = true
  config_backup_password = "Password!123"
  console_password       = "Password!123"
  instance_size          = "t3.medium"
  name                   = "terraform-aws-sophos-firewall"
  send_stats             = "on"
  sku                    = "payg"
  trusted_ip             = "47.184.79.94/32"
}