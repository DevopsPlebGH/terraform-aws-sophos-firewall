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

resource "random_id" "this" {
  prefix      = "example-complete"
  byte_length = 1
}

module "key-pair" {
  source             = "terraform-aws-modules/key-pair/aws"
  version            = "2.0.0"
  key_name           = "sophos-${random_id.this.hex}"
  create_private_key = true
}

module "complete" {
  source                    = "../../"
  create_vpc                = true
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

module "cloudformation-stack" {
  source  = "cloudposse/cloudformation-stack/aws"
  version = "0.7.1"
  # insert the 13 required variables here
  enabled      = true
  namespace    = "cft"
  stage        = "dev"
  name         = "sophos-xg-fw"
  template_url = "https://s3.amazonaws.com/awsmp-fulfillment-cf-templates-prod/336ce6d8-8e8b-4f15-a35c-f524e4fdcce2.97b34878-cd88-4c6d-a955-4a06f6e36f10.template"
  parameters = {
    AMI                      = "autodetect"
    AvailabilityZone         = "us-west-1b"
    PublicNetworkPrefix      = "10.15"
    OptExistingVPC           = ""
    OptExistingSubnetPublic  = ""
    OptExistingSubnetPrivate = ""
    TrustedNetworkCIDR       = "47.184.79.94/32"
    PublicNetworkCIDR        = "0.0.0.0/0"
    OptUsingEIPonFirewall    = "yes"
    OptExistingElasticIpId   = ""
    InstanceSize             = "t3.medium"
    KeyName                  = "${module.key-pair.key_pair_name}"
    ExistingS3Bucket         = ""
    SophosFirewallName       = "sophos-cft-firewall"
    BasicAdminPassword       = "${var.console_password}"
    ConfigBackupPassword     = "${var.config_backup_password}"
    SSMKPassword             = "${var.secure_storage_master_key}"
    AgreeUserTerms           = "yes"
    SendLearningStats        = "on"
    CentralUsername          = ""
    CentralPassword          = ""
  }
  capabilities = ["CAPABILITY_IAM", "CAPABILITY_NAMED_IAM", "CAPABILITY_AUTO_EXPAND"]
}
