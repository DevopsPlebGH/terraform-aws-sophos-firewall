locals {
  ifconfig_co_json = jsondecode(data.http.my_public_ip.response_body)
  my_ip            = [join("/", ["${local.ifconfig_co_json.ip}"], ["32"])]
  trusted_ip       = var.trusted_ip == null ? var.trusted_ip : local.my_ip
  network_prefix   = parseint(regex("/(\\d+)$", "${var.cidr_block}")[0], 10)
  new_bits         = var.subnet_prefix - local.network_prefix
  public_subnet    = element(cidrsubnets("${var.cidr_block}", "${local.new_bits}", "${local.new_bits}"), 0)
  private_subnet   = element(cidrsubnets("${var.cidr_block}", "${local.new_bits}", "${local.new_bits}"), 1)
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

### Subnets ###
# Public subnet
resource "aws_subnet" "public" {
  count                   = var.create_vpc ? 1 : 0
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.public_subnet != null ? var.public_subnet : local.public_subnet
  availability_zone       = var.az == null ? var.az : element("${random_shuffle.az.result}", 0)
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "public-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.public_subnet_tags,
    var.tags
  )
}

# Private subnet
resource "aws_subnet" "private" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnet != null ? var.private_subnet : local.private_subnet
  availability_zone = var.az == null ? var.az : element("${random_shuffle.az.result}", 0)
  tags = merge(
    { Name = "${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" }
  )
}

### Supporting resources ###
# Random ID
resource "random_id" "this" {
  prefix      = var.namespace
  byte_length = 1
}

# Random Shuffle
resource "random_shuffle" "az" {
  input        = data.aws_availability_zones.available.names
  result_count = 1
}

