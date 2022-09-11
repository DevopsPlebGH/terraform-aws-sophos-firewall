# Local variables
locals {
  ifconfig_co_json    = jsondecode(data.http.my_public_ip.body)
  trusted_ip = [join("/", ["${local.ifconfig_co_json.ip}"], ["32"])]
  cidr_block = var.trusted_cidr == null ? var.trusted_cidr : local.trusted_ip
}

### Network resources ###
# VPC
resource "aws_vpc" "this" {
  count                = var.create_vpc ? 1 : 0
  cidr_block           = var.cidr
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags = merge(
    { Name = "vpc-${var.namespace}-${var.name}" },
    var.vpc_tags,
    var.tags
  )
}

# Public subnet
resource "aws_subnet" "public" {
  count = var.create_vpc ? 1 : 0
  # checkov:skip=BC_AWS_NETWORKING_53: Need to allow public IP address to access firewall
  vpc_id                  = aws_vpc.this[0].id
  cidr_block              = var.public_subnet
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true
  tags = merge(
    { Name = "${var.namespace}-${var.name}-${var.public_subnet_suffix}" },
    var.public_subnet_tags,
    var.tags
  )
}

# Public subnet route table
resource "aws_route_table" "public" {
  count  = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "rtb-${var.name}-${var.public_subnet_suffix}" },
    var.private_route_table_tags,
    var.tags
  )
}

# Public subnet security groups
resource "aws_security_group" "public" {
  # checkov:skip=BC_AWS_NETWORKING_2: Not applicable to firewall
  count       = var.create_vpc ? 1 : 0
  name        = "Public Subnet"
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
    { Name = "Public Subnet" },
    var.security_group_tags,
    var.tags
  )
}

resource "aws_security_group" "trusted" {
  count = var.create_vpc ? 1 : 0
  name        = "Trusted Network"
  description = "Enable TCP access from trusted network"
  vpc_id      = aws_vpc.this[0].id
  ingress {
    description = "Allow all from trusted IP"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = local.cidr_block
  }
  egress {
    description = "Allow all traffic outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    { Name = "sg-${var.name}-trusted-${var.public_subnet_suffix}" },
    var.security_group_tags,
    var.tags
  )
}
# Private subnet
resource "aws_subnet" "private" {
  count       = var.create_vpc ? 1 : 0
  vpc_id            = aws_vpc.this[0].id
  cidr_block        = var.private_subnet
  availability_zone = data.aws_availability_zones.available.names[0]
  tags = merge(
    { Name = "Trusted Network" },
    var.private_subnet_tags,
    var.tags
  )
}

# Private subnet route table
resource "aws_route_table" "private" {
  count       = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "rtb-${var.name}-${var.private_subnet_suffix}" },
    var.private_route_table_tags,
    var.tags
  )
}

# Private subnet security groups
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
    { Name = "sg-${var.namespace}-${var.name}-${var.private_subnet_suffix}" },
    var.security_group_tags,
    var.tags
  )
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  count       = var.create_vpc ? 1 : 0
  vpc_id = aws_vpc.this[0].id
  tags = merge(
    { Name = "igw-${var.namespace}-${var.name}-${var.namespace}" },
    var.internet_gateway_tags,
    var.tags
  )
}

# Internet gateway route
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this[0].id
  timeouts {
    create = "5m"
  }
}

### EC2 Resources ###
# Elastic IP Address
# Public Elastic IP
resource "aws_eip" "this" {
  vpc                       = true
  network_interface = aws_network_interface.public.id
  tags = merge(
    { Name = "eip-${var.namespace}-${var.name}"},
    var.tags
  )
}
# Elastic Network Interfaces
# Public ENI
resource "aws_network_interface" "public" {
  subnet_id   = aws_subnet.public[0].id
  description = "ENI for Public Subnet"
  security_groups = [
    aws_security_group.trusted[0].id,
    aws_security_group.public[0].id
  ]
  tags = merge(
    { Name = "publicENI-${var.namespace}-${var.name}" },
    var.public_eni_tags,
    var.tags
  )
}

# Private ENI
resource "aws_network_interface" "private" {
  subnet_id   = aws_subnet.private[0].id
  description = "ENI for Private Subnet"
  security_groups = [
    aws_security_group.lan[0].id
  ]
  tags = merge(
    { Name = "privateENI-${var.namespace}-${var.name}" },
    var.private_eni_tags,
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
  root_block_device {
    encrypted     = false
    volume_size   = 16
    volume_type = "gp2"
    iops = 100
  }
  ebs_block_device {
    device_name = "/dev/xvdg"
    encrypted = false
    volume_size = 80
    volume_type = "gp2"
    iops = 240
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  iam_instance_profile = aws_iam_instance_profile.this.name
  monitoring = true
  tags = merge(
    { Name = "${var.firewall_hostname}" },
    { namespace = var.namespace },
    var.instance_tags,
    var.tags
  )
  ebs_optimized = false
}


### IAM Resources ###
# EC2 Instance Profile
resource "aws_iam_instance_profile" "this" {
  name = "${var.namespace}-${var.name}-EC2IAMProfile"
  role = aws_iam_role.this.name
  tags = merge(
    var.instance_profile_tags,
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
    name   = "EC2IAMPolicyForSSMK"
    policy = data.aws_iam_policy_document.ec2_iam_policy_ssmk.json
  }
  tags = merge(
    var.iam_role_tags,
    var.tags
  )
}

resource "aws_iam_role_policy" "central_policy" {
  count = var.register_in_central ? 1 : 0
  name = "EC2IAMPolicyForCentral"
  role = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.ec2_iam_policy_central[0].json[count.index]
}
# EC2 Launch Template
resource "aws_launch_template" "this" {
  name          = var.name
  instance_type = lookup(var.instance_type, var.size, "medium")
  image_id      = data.aws_ami.sfos_payg.id
  key_name      = var.key_name
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
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
  user_data = base64encode(jsonencode("${data.template_file.user_data.rendered}"))
  tags = merge(
    var.launch_template_tags,
    var.tags
  )
}

### AWS Secrets Manager Resources ###
# Secure Storage Master Key Secret
resource "aws_secretsmanager_secret" "ssmk" {
	# checkov:skip=BC_AWS_GENERAL_79: Customer Managed Key not needed
  name                    = "${var.name}-ssmk"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "ssmk" {
  secret_id     = aws_secretsmanager_secret.ssmk.id
  secret_string = var.secure_storage_master_key
}

# XG Backup Configuration Password
resource "aws_secretsmanager_secret" "xgconfig" {
	# checkov:skip=BC_AWS_GENERAL_79: Customer Managed Key not needed
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
  count = var.register_in_central ? 1 : 0
  name                    = "${var.name}-centralpass"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "centralpass" {
  secret_id     = aws_secretsmanager_secret.centralpass[0].id
  secret_string = var.central_password
}
