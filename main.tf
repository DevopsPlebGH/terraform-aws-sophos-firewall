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
# Resource creates the public subnet
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

# Resource creates the private subnet
resource "aws_subnet" "private" {
  count             = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnet != null ? var.private_subnet : local.private_subnet
  availability_zone = var.az == null ? var.az : element("${random_shuffle.az.result}", 0)
  tags = merge(
    { Name = "private-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" }
  )
}

### Security Groups ###
# Resource creates the security group to apply to the public subnet which blocks access to the firewall console ports and SSH ports.
resource "aws_security_group" "public" {
  count       = var.create_vpc ? 1 : 0
  name        = "Public"
  description = "Untrusted network restricted from access port 22 and 4444"
  vpc_id      = aws_vpc.this[0].id
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

# Resource creates the security group to allow access to the firewall management console
resource "aws_security_group" "trusted" {
  count       = var.create_vpc ? 1 : 0
  name        = "Trusted Network"
  description = "Enable TCP access from trusted network"
  vpc_id      = aws_vpc.this[0].id
  ingress {
    description = "Allow all from trusted IP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = local.trusted_ip
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

# Resource creates the sucurity group for the LAN subnet
resource "aws_security_group" "lan" {
  count       = var.create_vpc ? 1 : 0
  name        = "Private Subnet"
  description = "Security Group for private subnet. Allow everything by default"
  vpc_id      = aws_vpc.this[0].id
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
    { Name = "LAN" },
    var.security_group_tags,
    var.tags
  )
}

### Internet Gateway ###
# Resource creates an internet gateway in the VPC
resource "aws_internet_gateway" "this" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "igw-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.internet_gateway_tags,
    var.tags
  )
}

### Route Tables ###
# Resource creates the route table for the public subnet
resource "aws_route_table" "public" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "pub-rtb-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.public_route_table_tags,
    var.tags
  )
}

# Resource creates the route table for the private subnet
resource "aws_route_table" "private" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "priv-rtb-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.private_route_table_tags,
    var.tags
  )
}

## Route Table Associations ###
# Resources creates the public route table association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public[0].id
  route_table_id = aws_route_table.public[0].id
}

# Resource creates the private route table association
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private[0].id
  route_table_id = aws_route_table.private[0].id
}

### Routes ###
# Resource creates the public route
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
  timeouts {
    create = "5m"
  }
}

# Resource creates the private route
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private[0].id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.private.id
  timeouts {
    create = "5m"
  }
}

### Elastic Network Interfaces ###
# Resource creates a private ENI
resource "aws_network_interface" "private" {
  subnet_id       = aws_subnet.private[0].id
  description     = "ENI for private subnet"
  security_groups = [aws_security_group.lan[0].id]
  tags = merge(
    { Name = "priv-eni-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.private_eni_tags,
    var.tags
  )
}

# Resource creates a public ENI
resource "aws_network_interface" "public" {
  subnet_id   = aws_subnet.public[0].id
  description = "ENI for Public Subnet"
  security_groups = [
    aws_security_group.trusted[0].id,
    aws_security_group.public[0].id
  ]
  tags = merge(
    { Name = "pub-eni-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}" },
    var.public_eni_tags,
    var.tags
  )
}

### IAM Role ###
# Resource will create the EC2 IAM role
resource "aws_iam_role" "this" {
  name               = "ec2-iam-role-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}"
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
  inline_policy {
    name   = "ec2-policy-${random_id.this.hex}"
    policy = data.aws_iam_policy_document.ec2_iam_policy.json
  }
  inline_policy {
    name   = "ssm-policy-${random_id.this.hex}"
    policy = data.aws_iam_policy_document.secure_storage_master_key.json
  }
  tags = merge(
    var.iam_role_tags,
    var.tags
  )
}

### AWS Secrets Manager Resources ###
# Resource creates the XG Firewall Password secret
resource "aws_secretsmanager_secret" "console_password" {
  name                    = "sophos-fw-console-password"
  recovery_window_in_days = 0
}

# Resource creates the XG Firewall Secret
resource "aws_secretsmanager_secret_version" "console_password" {
  secret_id     = aws_secretsmanager_secret.console_password.id
  secret_string = var.console_password
}

# Resource creates the XG Firewall backup configuration password secret
resource "aws_secretsmanager_secret" "config_backup_password" {
  name                    = "sophos-fw-backup-configuration-password"
  recovery_window_in_days = 0
}

# Resource creates the XG Firewall backup configuration secret
resource "aws_secretsmanager_secret_version" "config_backup_password" {
  secret_id     = aws_secretsmanager_secret.config_backup_password.id
  secret_string = var.config_backup_password
}

# Resource creates the Secure Storage Master Key password secret
resource "aws_secretsmanager_secret" "secure_storage_master_key" {
  name                    = "sophos-fw-secure-storage-master-key"
  recovery_window_in_days = 0
}

# Resource creates the Secure Storage Master Key secret
resource "aws_secretsmanager_secret_version" "secure_storage_master_key" {
  secret_id     = aws_secretsmanager_secret.secure_storage_master_key.id
  secret_string = var.secure_storage_master_key
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

