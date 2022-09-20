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

variable "instance_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the EC2 instance

  Default: {}
  EOT
  default     = {}
}

variable "instance_type" {
  type        = map(any)
  description = <<EOT
  (Optional) The EC2 instance type to use for the firewall
  EOT
  default = {
    "t3.small"   = "t3.small"
    "t3.medium"  = "t3.medium"
    "m3.xlarge"  = "m3.xlarge"
    "m3.2xlarge" = "m3.2xlarge"
    "m4.large"   = "m4.large"
    "m4.xlarge"  = "m4.xlarge"
    "m5.large"   = "m5.large"
    "m5.xlarge"  = "m5.xlarge"
    "m5.2xlarge" = "m5.2xlarge"
    "c3.xlarge"  = "c3.xlarge"
    "c3.2xlarge" = "c3.2xlarge"
    "c3.4xlarge" = "c3.4xlarge"
    "c3.8xlarge" = "c3.8xlarge"
    "c4.large"   = "c4.large"
    "c4.xlarge"  = "c4.xlarge"
    "c4.2xlarge" = "c4.2xlarge"
    "c4.4xlarge" = "c4.4xlarge"
    "c4.8xlarge" = "c4.8xlarge"
    "c5.large"   = "c5.large"
    "c5.xlarge"  = "c5.xlarge"
    "c5.2xlarge" = "c5.2xlarge"
  }
}

variable "internet_gateway_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to created internet gateways

  Default: {}
  EOT
  default     = {}
}

variable "latest" {
  type        = bool
  description = <<EOT
  (Optional) Whether or not to use the latest version of the AMI.

  Default: true
  EOT
  default     = true
}

variable "launch_template_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the launch template

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

variable "ssh_key_name" {
  type        = string
  description = <<EOT
  (Required) The name of the SSH key to use to authenticate to the firewall.

  EOT
}

variable "size" {
  type        = string
  description = <<EOT
  (Optional) The size of the instance to deploy.

  Default: "m5.large"
  EOT
  default     = "m5.large"
}

variable "sfos_version" {
  type        = string
  description = <<EOT
  (Optional) The firmware version to use for the deployed firewall

  Default: "latest"
  EOT
  default     = "latest"
}

variable "sfos_versions" {
  type        = map(any)
  description = <<EOT
    (Optional) Version of SFOS firmware to use with the EC2 instance

    Default: ""
  EOT
  default = {
    "latest"   = "19.0.0.317"
    "18.0 MR3" = "18.0.3.457"
    "18.0 MR4" = "18.0.4.506"
    "18.0 MR5" = "18.0.5.585"
    "18.5 MR1" = "18.5.1.326"
    "18.5 MR2" = "18.5.2.380"
    "18.5 MR3" = "18.5.3.408"
  }
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

    Default: []
    EOT
  default     = []
}

variable "vpc_tags" {
  type        = map(string)
  description = <<EOT
    (Optional) Additional tags to attach to the VPC

    Default: {}
    EOT
  default     = {}
}
