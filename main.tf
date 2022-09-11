locals {
    ifconfig_co_json = jsondecode(data.http.my_public_ip.body)
    my_ip = [join("/", ["${local.ifconfig_co_json.ip}"], ["32"])]
    trusted_ip = var.trusted_ip == null ? var.trusted_ip : local.my_ip
}

### VPC ###
# VPC is created if no existing VPC is specified or defined
resource "aws_vpc" "this" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    { Name = "${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.vpc_tags,
    var.tags
  )
}

### Supporting resources ###
# Random ID
resource "random_id" "this" {
  prefix      = var.namespace
  byte_length = 1
}
