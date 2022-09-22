locals {
  availability_zone_map = {
    for zone in data.aws_availability_zone.available :
    zone.name => zone.zone_id
  }
  deploy_date      = formatdate("MM-DD-YYYY", timestamp())
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
  runner_ip        = [join("/", [local.ifconfig_co_json.ip], ["32"])]
  trusted_cidrs    = concat(compact(formatlist(var.trusted_ip)), compact(local.runner_ip))
}

module "key-pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  version            = "2.0.0"
  key_name           = "sophos"
  create_private_key = true
}

module "complete" {
  source     = "../../"
  create_vpc = true
  vpc_tags = {

  }
  aws_region                = data.aws_region.current.name
  availability_zone         = data.aws_availability_zones.available.names[0]
  console_password          = var.console_password
  firewall_hostname         = "sophos-xg-terraform"
  ssh_key_name              = module.key-pair.key_pair_name
  secure_storage_master_key = var.secure_storage_master_key
  config_backup_password    = var.config_backup_password
  send_stats                = "on"
  instance_size             = "t3.medium"
  eula                      = "yes"
  trusted_ip                = local.trusted_cidrs
  sku                       = "payg"
  create_elastic_ip         = true
  create_s3_bucket          = false
  tags = {
    managed_by    = "Terraform",
    contact_email = "ralph.brynard@sophos.com",
    creation_date = local.deploy_date
  }
}

