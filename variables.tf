variable "az" {
  type        = string
  description = <<EOT
  (Optional) The availability zone in which to deploy the firewall.

  If not defined, this value will be derived from a randomly selected AZ via the aws_availability_zones data source.

  Default: ""
  EOT
  default     = null
}

variable "central_password" {
  type        = string
  description = <<EOT
  (Optional) The password for your Sophos Central account if you would like to register the firewall with Sophos Central

  Default: null
  EOT
  default     = ""
}

variable "cidr_block" {
  type        = string
  description = <<EOT
    (Optional) The CIDR range for the VPC CIDR block.

    Default: "10.0.0.0/16"
    EOT
  default     = "10.0.0.0/16"
}

variable "config_backup_password" {
  type        = string
  description = <<EOT
  (Required) The password to secure the configuration backup.

  EOT
}

variable "console_password" {
  type        = string
  description = <<EOT
  (Required) The password for the firewall management console.

  EOT
}

variable "create_vpc" {
  type        = bool
  description = <<EOT
    (Optional) Controls whether or not a new VPC should be created or if an existing VPC should be used.

    Default: true
    EOT
  default     = "true"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = <<EOT
    (Optional) Controls whether or not DNS hostname support should be enabled in the VPC

    Default: true
    EOT
  default     = true
}

variable "enable_dns_support" {
  type        = bool
  description = <<EOT
  (Optional) Controls whether DNS support should be enabled in the VPC

  Default: true
  EOT
  default     = true
}

variable "iam_role_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to created IAM roles

  Default: {}
  EOT
  default     = {}
}

variable "instance_profile_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to instance profile

  Default: {}
  EOT
  default     = {}
}

variable "internet_gateway_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to created internet gateways

  Default: {}
  EOT
  default     = {}
}

variable "namespace" {
  type        = string
  description = <<EOT
    (Optional) Namespace refers to the application or deployment type.

    EG: sophos-xg, sophos-optix, sophos-cwp, etc...

    Default: sophos-xg
    EOT
  default     = "sophos-xg"
}

variable "private_eni_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the private ENI

  Default: {}
  EOT
  default     = {}
}

variable "private_route_table_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the public route table

  Default: {}
  EOT
  default     = {}
}

variable "private_subnet" {
  type        = string
  description = <<EOT
  (Optional) The CIDR block of the private subnet. Conflicts with subnet_prefix

  Default: null
  EOT
  default     = null
}

variable "public_eni_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the public ENI

  Default: {}
  EOT
  default     = {}
}

variable "public_route_table_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the Public Route Table

  Default: {}
  EOT
  default     = {}
}

variable "public_subnet" {
  type        = string
  description = <<EOT
  (Optional) The CIDR block of the public subnet. Conflicts with subnet_prefix.

  Default: null
  EOT
  default     = null
}

variable "public_subnet_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags for the public subnets.

  Default: {}
  EOT
  default     = {}
}

variable "security_group_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to security groups

  Default: {}
  EOT
  default     = {}
}

variable "secure_storage_master_key" {
  type        = string
  description = <<EOT
  (Required) The Secure Storage Master Key password.
  EOT
}

variable "sfos_version" {
  type        = string
  description = <<EOT
    (Optional) Version of SFOS firmware to use with the EC2 instance

    Default: ""
  EOT
  default     = ""
}

variable "sku" {
  type        = string
  description = <<EOT
  (Optional) The SKU to use for the AMI. Can be either payg or byol

  Default: payg
  EOT
  default     = "payg"
}

variable "subnet_prefix" {
  type        = string
  description = <<EOT
  (Optional) The subnet prefix. Conflicts with public_subnet/private_subnet.

  Default: "24"
  EOT
  default     = "24"
}

variable "tags" {
  type        = map(string)
  description = <<EOT
    (Optional) A map of tags to add to all resources

    Default: {}
    EOT
  default     = {}
}

variable "trusted_ip" {
  type        = list(string)
  description = <<EOT
    (Optional) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.

    The default behavior is to include the public IP address from which the Terraform plan is run.

    EG: 192.168.10.24/32

    Default: [null]
    EOT
  default     = [null]
}

variable "vpc_tags" {
  type        = map(string)
  description = <<EOT
    (Optional) Additional tags to attach to the VPC

    Default: {}
    EOT
  default     = {}
}
