// Locals
locals {
  name_prefix    = random_id.this.dec
  network_prefix = parseint(regex("/(\\d+)$", "${var.cidr_block}")[0], 10)
  new_bits       = var.subnet_prefix - local.network_prefix
  public_subnet  = element(cidrsubnets("${var.cidr_block}", "${local.new_bits}", "${local.new_bits}"), 0)
  private_subnet = element(cidrsubnets("${var.cidr_block}", "${local.new_bits}", "${local.new_bits}"), 1)
  sfos_version   = lookup(var.sfos_versions, var.sfos_version, "autodetect")
  amis           = { for k, v in data.aws_ami.dynamic_ami : k => v.description }
  sfos_ami       = [for k, v in local.amis : k if v == "XG on AWS ${local.sfos_version}-${var.sku}"]
}
// Random ID
resource "random_id" "this" {
  prefix      = "sophos-xg-"
  byte_length = 3
}

// If create_vpc is true, create VPC.
resource "aws_vpc" "this" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    { Name = var.name },
    var.vpc_tags,
    var.tags
  )
}

// Public Subnet
resource "aws_subnet" "public" {
  count                   = var.create_vpc ? 1 : 0
  vpc_id                  = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  cidr_block              = var.public_subnet != null ? var.public_subnet : local.public_subnet
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "Public Subnet" },
    var.public_subnet_tags,
    var.tags
  )
}

// Public subnet security group
resource "aws_security_group" "public" {
  count       = var.create_vpc ? 1 : 0
  name        = "Public"
  description = "Untrusted network restricted from access port 22 and 4444"
  vpc_id      = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  ingress {
    description = "Allow public access 0 - 21"
    from_port   = 0
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow public access 23 - 4443"
    from_port   = 23
    to_port     = 4443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow public access 4445 - 65535"
    from_port   = 4445
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all traffic outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "Public" },
    var.security_group_tags,
    var.tags
  )
}

//Private Subnet
resource "aws_subnet" "private" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  cidr_block        = var.private_subnet != null ? var.private_subnet : local.private_subnet
  availability_zone = var.availability_zone
  tags = merge(
    { Name = "Private Subnet" },
    var.private_subnet_tags,
    var.tags
  )
}

//  Trusted Security Group
resource "aws_security_group" "trusted" {
  count       = var.create_vpc ? 1 : 0
  name        = "Trusted Network"
  description = "Enable TCP access from trusted network"
  vpc_id      = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  ingress {
    description = "Allow all from trusted IP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.trusted_ip]
  }
  egress {
    description = "Allow all traffic outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "Trusted Network" },
    var.security_group_tags,
    var.tags
  )
}

// LAN Security Group
resource "aws_security_group" "lan" {
  count       = var.create_vpc ? 1 : 0
  name        = "Private Subnet"
  description = "Security Group for private subnet. Allow everything by default"
  vpc_id      = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  ingress {
    description = "Allow all inbound from private subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Allow all outbound from private subnet"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "LAN" },
    var.security_group_tags,
    var.tags
  )
}

// Internet Gateway
resource "aws_internet_gateway" "this" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  tags = merge(
    { Name = "Internet Gateway" },
    var.internet_gateway_tags,
    var.tags
  )
}

// Public Route Table
resource "aws_route_table" "public" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  tags = merge(
    { Name = "Public Route Table" },
    var.public_route_table_tags,
    var.tags
  )
}

// Public Route Table Association
resource "aws_route_table_association" "public" {
  subnet_id      = var.public_subnet_id != null ? var.public_subnet_id : aws_subnet.public[0].id
  route_table_id = var.route_table_id != null ? var.route_table_id : aws_route_table.public[0].id
}

// Public Route
resource "aws_route" "public" {
  route_table_id         = var.route_table_id != null ? var.route_table_id : aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
  timeouts {
    create = "5m"
  }
}

// Private Route Table
resource "aws_route_table" "private" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = var.vpc_id != null ? var.vpc_id : aws_vpc.this[0].id
  tags = merge(
    { Name = "Private Route Table" },
    var.private_route_table_tags,
    var.tags
  )
}

// Private Route Table Association
resource "aws_route_table_association" "private" {
  subnet_id      = var.private_subnet_id != null ? var.private_subnet_id : aws_subnet.private[0].id
  route_table_id = var.route_table_id != null ? var.route_table_id : aws_route_table.private[0].id
}

// Private Route
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.private.id
  timeouts {
    create = "5m"
  }
}

// Private ENI
resource "aws_network_interface" "private" {
  subnet_id         = var.private_subnet_id != null ? var.private_subnet_id : aws_subnet.private[0].id
  description       = "ENI for Private Subnet"
  security_groups   = [aws_security_group.lan[0].id]
  source_dest_check = false
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    { Name = "Private ENI" },
    var.private_eni_tags,
    var.tags
  )
}

// Public ENI
resource "aws_network_interface" "public" {
  subnet_id   = aws_subnet.public[0].id
  description = "ENI for Public Subnet"
  security_groups = [
    aws_security_group.trusted[0].id,
    aws_security_group.public[0].id
  ]
  source_dest_check = false
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    { Name = "Public ENI" },
    var.public_eni_tags,
    var.tags
  )
}

// Elastic IP
resource "aws_eip" "this" {
  count = var.create_elastic_ip ? 1 : 0
  vpc   = true
  # network_interface = var.network_interface_id != null ? var.network_interface_id : aws_network_interface.public.id
  # associate_with_private_ip = aws_network_interface.public.private_ip
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    { Name = local.name_prefix },
    var.elastic_ip_tags,
    var.tags
  )
}

// Elastic IP Association
resource "aws_eip_association" "this" {
  count                = var.create_elastic_ip ? 1 : 0
  network_interface_id = var.network_interface_id != null ? var.network_interface_id : aws_network_interface.public.id
  private_ip_address   = aws_network_interface.public.private_ip
  allocation_id        = data.aws_eip.by_filter.id
}

// IAM Instance Profile
resource "aws_iam_instance_profile" "xg" {
  name_prefix = local.name_prefix
  role        = aws_iam_role.xg.name
  tags = merge(
    var.instance_profile_tags,
    var.tags
  )
}

// EC2 IAM Role
resource "aws_iam_role" "xg" {
  name_prefix = local.name_prefix
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  tags = merge(
    var.iam_role_tags,
    var.tags
  )
}

// EC2 IAM Role Policy
resource "aws_iam_role_policy" "xg" {
  name_prefix = local.name_prefix
  role        = aws_iam_role.xg.id
  policy      = data.aws_iam_policy_document.policy.json
}

// EC2 Launch Template
locals {
  user_data_temp = tomap({
    ssmkSecretId    = try(var.secure_storage_master_key == null ? null : aws_secretsmanager_secret.secure_storage_master_key[0].arn),
    s3bucket        = try(var.s3bucket == null ? null : var.s3bucket),
    centralusername = try(var.central_username == null ? null : var.central_username),
    centralpassword = try(var.central_password == null ? null : aws_secretsmanager_secret.central_password[0].arn),
    sendstats       = try(var.send_stats == null ? null : var.send_stats),
    region          = try(var.aws_region == null ? null : var.aws_region),
    secretId        = try(var.console_password == null ? null : aws_secretsmanager_secret.console_password.arn),
    configSecretId  = try(var.config_backup_password == null ? null : aws_secretsmanager_secret.config_backup_password.arn),
    serialKey       = try(var.serial_number == "" ? null : var.serial_number),
    hostname        = try(var.firewall_hostname == null ? null : var.firewall_hostname)
  })
  user_data = {
    for k, v in "${local.user_data_temp}" :
    k => v if v != null
  }
}
resource "aws_launch_template" "xg" {
  name_prefix   = local.name_prefix
  instance_type = lookup(var.instance_type, var.instance_size, "m5.large")
  image_id      = element(local.sfos_ami, 0)
  key_name      = var.ssh_key_name != null ? var.ssh_key_name : aws_key_pair.this[0].key_name
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      delete_on_termination = true
      volume_size           = "16"
      volume_type           = "gp2"
      encrypted             = false
    }
  }
  block_device_mappings {
    device_name = "/dev/xvdg"
    ebs {
      delete_on_termination = true
      volume_size           = "80"
      volume_type           = "gp2"
      encrypted             = false
    }
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  iam_instance_profile {
    name = aws_iam_role.xg.name
  }
  user_data = base64encode(jsonencode(local.user_data))
  tags = merge(
    var.launch_template_tags,
    var.tags
  )
}

// EC2 Locals
locals {
  validate_sku_byol_condition = var.sku == "payg" && var.serial_number != ""
  validate_sku_byol_message   = <<EOT
  ERROR: Incorrect SKU type for provided serial number!

  If providing a serial number, SKU type must be "byol"
  EOT
  validate_sku_byol_check = regex(
    "^${local.validate_sku_byol_message}$",
    (!local.validate_sku_byol_condition
      ? local.validate_sku_byol_message
    : "")
  )
}
// EC2 Instance
resource "aws_instance" "this" {
  launch_template {
    id      = aws_launch_template.xg.id
    version = "$Latest"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "optional"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  network_interface {
    network_interface_id = aws_network_interface.public.id
    device_index         = 1
  }
  network_interface {
    network_interface_id = aws_network_interface.private.id
    device_index         = 0
  }
  iam_instance_profile        = aws_iam_instance_profile.xg.name
  user_data_base64            = base64encode(jsonencode(local.user_data))
  user_data_replace_on_change = true
  monitoring                  = true
  ebs_optimized               = false
  tags = merge(
    { Name = var.firewall_hostname },
    var.instance_tags,
    var.tags
  )
}

// EC2 Key Pair
resource "aws_key_pair" "this" {
  count           = var.create_key_pair ? 1 : 0
  key_name_prefix = local.name_prefix
  public_key      = var.create_private_key ? trimspace(tls_private_key.this[0].public_key_openssh) : var.public_key
  tags            = var.tags
}

resource "tls_private_key" "this" {
  count     = var.create_key_pair && var.create_private_key ? 1 : 0
  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}

// Secrets Manager Secrets
resource "aws_secretsmanager_secret" "console_password" {
  name_prefix             = "console_password"
  recovery_window_in_days = 0
  tags = {
    app = "sophos_xg_firewall"
  }
}

resource "aws_secretsmanager_secret_version" "console_password" {
  secret_id     = aws_secretsmanager_secret.console_password.id
  secret_string = var.console_password
}

resource "aws_secretsmanager_secret" "config_backup_password" {
  name_prefix             = "config_backup_password"
  recovery_window_in_days = 0
  tags = {
    app = "sophos_xg_firewall"
  }
}

resource "aws_secretsmanager_secret_version" "config_backup_password" {
  secret_id     = aws_secretsmanager_secret.config_backup_password.id
  secret_string = var.config_backup_password
}

resource "aws_secretsmanager_secret" "secure_storage_master_key" {
  count                   = var.secure_storage_master_key != null ? 1 : 0
  name_prefix             = "secure_storage_master_key"
  recovery_window_in_days = 0
  tags = {
    app = "sophos_xg_firewall"
  }
}

resource "aws_secretsmanager_secret_version" "secure_storage_master_key" {
  count         = var.secure_storage_master_key != null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.secure_storage_master_key[0].id
  secret_string = var.secure_storage_master_key
}

resource "aws_secretsmanager_secret" "central_password" {
  count                   = var.central_password != null ? 1 : 0
  name_prefix             = "sophos_central_password"
  recovery_window_in_days = 0
  tags = {
    app = "sophos_xg_firewall"
  }
}

resource "aws_secretsmanager_secret_version" "central_password" {
  count         = var.central_password != null ? 1 : 0
  secret_id     = aws_secretsmanager_secret.central_password[0].id
  secret_string = var.central_password
}