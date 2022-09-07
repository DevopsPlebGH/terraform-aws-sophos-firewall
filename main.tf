# Local variables
locals {
  name                = "${var.vpc_prefix}${var.name}${var.namespace}"
  public_subnet_name  = "${var.public_subnet_prefix}${var.name}${var.namespace}"
  private_subnet_name = "${var.private_subnet_prefix}${var.name}${var.namespace}"
  prefix              = "${var.prefix}${var.namespace}"

  default_tags = {
    managed_by    = "terraform"
    date_created  = formatdate("MM-DD-YYYY", timestamp())
    created_by    = var.created_by
    team          = var.team
    environment   = var.environment
    namespace     = var.namespace
    contact_email = var.contact_email
  }
}

### Network resources ###
# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    { Name = "${local.name}" },
    { resource = "VPC" },
    var.tags
  )
}

# Public subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "${local.public_subnet_name}" },
    { resource = "public subnet" },
    local.default_tags,
    var.tags
  )
}

# Public subnet route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { Name = "${local.public_subnet_name}" },
    { resource = "Route table for public subnet" },
    local.default_tags,
    var.tags
  )
}

# Public subnet security groups
resource "aws_security_group" "public" {
  name        = "Public Subnet"
  description = "Untrusted network restricted from access port 22 and 4444"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = 0
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 23
    to_port     = 4443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 4445
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "Public Subnet" },
    { resource = "Untrusted network security group" },
    local.default_tags,
    var.tags
  )
}

resource "aws_security_group" "trusted" {
  name        = "Trusted Network"
  description = "Enable TCP access from trusted network"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.trusted_cidr
  }
  tags = merge(
    { Name = "Trusted Network" },
    { resource = "Trusted network security group" },
    local.default_tags,
    var.tags
  )
}
# Private subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(
    { Name = "${local.private_subnet_name}" },
    { resource = "private subnet" },
    local.default_tags,
    var.tags
  )
}

# Private subnet route table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { Name = "${local.private_subnet_name}" },
    { resource = "Route table for private subnet" },
    local.default_tags,
    var.tags
  )
}

# Private subnet security groups
resource "aws_security_group" "lan" {
  name        = "Private Subnet"
  description = "Security Group for private subnet. Allow everything by default"
  vpc_id      = aws_vpc.this.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "Private Subnet" },
    { resource = "Private subnet security groups" },
    local.default_tags,
    var.tags
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    { Name = "${var.name}" },
    { resource = "Internet Gateway" },
    local.default_tags,
    var.tags
  )
}

# Internet gateway route
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
  timeouts {
    create = "5m"
  }
}

### EC2 Resources ###
# Elastic Network Interfaces
# Public ENI
resource "aws_network_interface" "public" {
  subnet_id   = aws_subnet.public.id
  description = "ENI for Public Subnet"
  security_groups = [
    aws_security_group.trusted.id,
    aws_security_group.public.id
  ]
  private_ips = ["172.16.17.17"]
  tags = merge(
    { Name = "WAN" },
    { resource = "Public ENI" },
    local.default_tags,
    var.tags
  )
}

# Private ENI
resource "aws_network_interface" "private" {
  subnet_id   = aws_subnet.private.id
  description = "ENI for Private Subnet"
  security_groups = [
    aws_security_group.lan.id
  ]
  private_ips = ["172.16.16.16"]
  tags = merge(
    { Name = "LAN" },
    { resource = "Private ENI" },
    local.default_tags,
    var.tags
  )
}

# EC2 Instance
resource "aws_instance" "this" {
  ami = data.aws_ami.sfos_payg.image_id
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  tags = merge(
    { Name = "${var.firewall_hostname}" },
    { resource = "Sophos XG Firewall" },
    local.default_tags,
    var.tags
  )
}

### IAM Resources ###
# EC2 Instance Profile
resource "aws_iam_instance_profile" "this" {
  name = "${var.name}-EC2IAMProfile"
  role = aws_iam_role.this.name
  tags = merge(
    { resource = "EC2 IAM Instance Profile" },
    local.default_tags,
    var.tags
  )
}

# EC2 IAM Role
resource "aws_iam_role" "this" {
  name               = "${var.name}-EC2IAMRole"
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
  inline_policy {
    name   = "EC2IAMPolicy"
    policy = data.aws_iam_policy_document.ec2_iam_policy.json
  }
  inline_policy {
    name   = "EC2IAMPolicyForCentral"
    policy = data.aws_iam_policy_document.ec2_iam_policy_central.json
  }
  inline_policy {
    name   = "EC2IAMPolicyForSSMK"
    policy = data.aws_iam_policy_document.ec2_iam_policy_ssmk.json
  }
  tags = merge(
    { resource = "EC2 IAM Role" },
    local.default_tags,
    var.tags
  )
}

# EC2 Launch Template
resource "aws_launch_template" "this" {
  name          = var.name
  instance_type = lookup(var.instance_type, var.size, "medium")
  image_id      = data.aws_ami.sfos_payg.id
  key_name      = var.key_name
  iam_instance_profile {
    name = aws_iam_role.this.name
  }
  network_interfaces {
    network_interface_id = aws_network_interface.public.id
    device_index         = 0
  }
  network_interfaces {
    network_interface_id = aws_network_interface.private.id
    device_index         = 1
  }
  user_data = base64encode("${data.template_file.user_data.rendered}")
}

### AWS Secrets Manager Resources ###
# Secure Storage Master Key Secret
resource "aws_secretsmanager_secret" "ssmk" {
  name                    = "${var.name}-ssmk"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "ssmk" {
  secret_id     = aws_secretsmanager_secret.ssmk.id
  secret_string = var.secure_storage_master_key
}

# XG Backup Configuration Password
resource "aws_secretsmanager_secret" "xgconfig" {
  name                    = "${var.name}-xgconfig"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "xgconfig" {
  secret_id     = aws_secretsmanager_secret.xgconfig.id
  secret_string = var.config_password
}

# Sophos Central Password
resource "aws_secretsmanager_secret" "sophospass" {
  name                    = "${var.name}-sophospass"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sophospass" {
  count         = var.register_in_central ? 1 : 0
  secret_id     = aws_secretsmanager_secret.sophospass.id
  secret_string = var.sophos_password
}

# Sophos Central Password
resource "aws_secretsmanager_secret" "centralpass" {
  name                    = "${var.name}-centralpass"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "centralpass" {
  count         = var.register_in_central ? 1 : 0
  secret_id     = aws_secretsmanager_secret.centralpass.id
  secret_string = var.central_password
}






resource "aws_key_pair" "this" {
  count = var.create_key_pair ? 1 : 0

  key_name        = var.key_name
  key_name_prefix = var.key_name_prefix
  public_key      = var.create_private_key ? trimspace(tls_private_key.this[0].public_key_openssh) : var.public_key

  tags = var.tags
}

resource "tls_private_key" "this" {
  count = var.create_key_pair && var.create_private_key ? 1 : 0

  algorithm = var.private_key_algorithm
  rsa_bits  = var.private_key_rsa_bits
}
