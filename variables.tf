//Variables
variable "accept_eula" {
  type        = string
  description = <<EOT
  (Required) Use of this software is subject to the Sophos End User License Agreement (EULA) at https://www.sophos.com/en-us/legal/sophos-end-user-license-agreement.aspx. You must enter 'yes' to accept the EULA to continue, so please read it carefully. You also acknowledge that Sophos processes personal data in accordance with the Sophos Privacy Policy at https://www.sophos.com/en-us/legal/sophos-group-privacy-notice.aspx
  EOT
  validation {
    condition     = contains(["yes", "no"], var.accept_eula)
    error_message = <<EOT
    ERROR: Provided value for the EULA agreement must be one of: [yes, no].
    EOT
  }
}
variable "app" {
  type        = string
  description = <<EOT
  (Optional) Sophos XG Deployment type: HA, Standalone, autoscaling

  Default: null
  EOT
  default     = null
}

variable "autodetect" {
  type        = bool
  description = <<EOT
  (Optional) Whether or not to use the latest version of the AMI.

  Default: true
  EOT
  default     = true
}

variable "availability_zone" {
  type        = string
  description = <<EOT
  (Required) The availability zone in which to deploy the firewall.
  EOT
}

variable "aws_region" {
  type        = string
  description = <<EOT
  (Required) The region in which to deploy the firewall
  EOT
}
variable "central_password" {
  type        = string
  description = <<EOT
  (Optional) The password for your Sophos Central account if you would like to register the firewall with Sophos Central

  Default: null
  EOT
  default     = null
}

variable "central_username" {
  type        = string
  description = <<EOT
  (Optional) Sophos Central username if registering the firewall to Central

  Default: null
  EOT
  default     = null
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
  validation {
    condition     = length(var.config_backup_password) >= 10
    error_message = <<EOT
    ERROR: Password must have at least 10 characters.
    EOT
  }
  validation {
    condition     = can(regex("[A-Z]", var.config_backup_password))
    error_message = <<EOT
    ERROR: Password must contain at least one uppercase letter.
    EOT
  }
  validation {
    condition     = can(regex("[a-z]", var.config_backup_password))
    error_message = <<EOT
    ERROR: Password must contain at least one lowercase letter.
    EOT
  }
  validation {
    condition     = can(regex("[^a-zA-Z0-9]", var.config_backup_password))
    error_message = <<EOT
    ERROR: Password must contain at least one character that isn't a letter or a digit.
    EOT
  }
  validation {
    condition     = can(regex("[0-9]", var.config_backup_password))
    error_message = <<EOT
    ERROR: Password must contain at least one digit.
    EOT
  }
}

variable "console_password" {
  type        = string
  description = <<EOT
  (Required) The password for the firewall management console.
  EOT
  validation {
    condition     = length(var.console_password) >= 10
    error_message = <<EOT
    ERROR: Password must have at least 10 characters.
    EOT
  }
  validation {
    condition     = can(regex("[A-Z]", var.console_password))
    error_message = <<EOT
    ERROR: Password must contain at least one uppercase letter.
    EOT
  }
  validation {
    condition     = can(regex("[a-z]", var.console_password))
    error_message = <<EOT
    ERROR: Password must contain at least one lowercase letter.
    EOT
  }
  validation {
    condition     = can(regex("[^a-zA-Z0-9]", var.console_password))
    error_message = <<EOT
    ERROR: Password must contain at least one character that isn't a letter or a digit.
    EOT
  }
  validation {
    condition     = can(regex("[0-9]", var.console_password))
    error_message = <<EOT
    ERROR: Password must contain at least one digit.
    EOT
  }
}

variable "create_elastic_ip" {
  type        = bool
  description = <<EOT
  (Optional) If set to false, an existing elastic IP allocation ID will need to be provided.
  EOT
  default     = true
}

variable "create_key_pair" {
  type        = bool
  description = <<EOT
  (Optional) Determines whether resources will be created (affects all resources)

  Default: true
  EOT
  default     = true
}
variable "create_private_key" {
  type        = bool
  description = <<EOT
  (Optional) Determines whether a private key will be created

  Default: true
  EOT
  default     = true
}

variable "create_s3_bucket" {
  type        = bool
  description = <<EOT
  (Optional) Whether or not an S3 bucket should be created for the firewall configuration backups.

  Default: false
  EOT
  default     = false
}

variable "create_vpc" {
  type        = bool
  description = <<EOT
    (Optional) If set to false, an existing VPC ID and existing subnet ID's will need to be provided.

    Default: false
    EOT
  default     = false
}

variable "elastic_ip_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the Elastic IP Address

  Default: {}
  EOT
  default     = {}
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

variable "environment" {
  type        = string
  description = <<EOT
  (Optional) ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'dev', 'stage'

  Default: null
  EOT
  default     = null
}

variable "firewall_hostname" {
  type        = string
  description = <<EOT
  (Optional) The hostname of the firewall

  Default: "sophos-firewall-tf"
  EOT
  default     = "sophos-firewall-tf"
}

variable "iam_role_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Map of additional tags to attach to the IAM role

  Default: {}
  EOT
  default     = {}
}

variable "instance_profile_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Map of additional tags to attach to the Instance Profile

  Default: {}
  EOT
  default     = {}
}

variable "instance_size" {
  type        = string
  description = <<EOT
  (Required) The size of the instance to deploy. Available instance sizes are:

    t3.small
    t3.medium
    m3.xlarge
    m3.2xlarge
    m4.large
    m4.xlarge
    m5.large
    m5.xlarge
    m5.2xlarge
    c3.xlarge
    c3.2xlarge
    c3.4xlarge
    c3.8xlarge
    c4.large
    c4.xlarge
    c4.2xlarge
    c4.4xlarge
    c4.8xlarge
    c5.large
    c5.xlarge
    c5.2xlarge

  Default: "m5.large"
  EOT
  validation {
    condition     = contains(["t3.small", "t3.medium", "m3.xlarge", "m3.2xlarge", "m4.large", "m4.xlarge", "m5.large", "m5.xlarge", "m5.2xlarge", "c3.xlarge", "c3.2xlarge", "c3.4xlarge", "c3.8xlarge", "c4.large", "c4.xlarge", "c4.2xlarge", "c4.4xlarge", "c4.8xlarge", "c5.large", "c5.xlarge", "c5.2xlarge"], var.instance_size)
    error_message = <<EOT
    ERROR: Invalid Instance Size! Valid instance sizes are:

      t3.small
      t3.medium
      m3.xlarge
      m3.2xlarge
      m4.large
      m4.xlarge
      m5.large
      m5.xlarge
      m5.2xlarge
      c3.xlarge
      c3.2xlarge
      c3.4xlarge
      c3.8xlarge
      c4.large
      c4.xlarge
      c4.2xlarge
      c4.4xlarge
      c4.8xlarge
      c5.large
      c5.xlarge
      c5.2xlarge
    EOT
  }
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

variable "launch_template_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the launch template

  Default: {}
  EOT
  default     = {}
}

variable "name" {
  type        = string
  description = <<EOT
  (Optional) ID element. Usually an abbreviation of your organization name to help ensure generated ID's are globally unique.

  Default: null
  EOT
  default     = null
}

variable "network_interface_id" {
  type        = string
  description = <<EOT
  (Optional) Network Interface ID

  Default: null
  EOT
  default     = null
}

variable "private_eni_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the private ENI

  Default: {}
  EOT
  default     = {}
}

variable "private_key_algorithm" {
  type        = string
  description = <<EOT
  (Optional) Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519`

  Default: RSA
  EOT
  default     = "RSA"
  validation {
    condition     = contains(["RSA", "ED25519"], var.private_key_algorithm)
    error_message = <<EOT
    ERROR: Private Key Algorith must be one of: RSA, ED25519
    EOT
  }
}

variable "private_key_rsa_bits" {
  description = "When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`)"
  type        = number
  default     = 4096
}

variable "private_route_table_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the Private Route Table

  Default: {}
  EOT
  default     = {}
}

variable "private_subnet" {
  type        = string
  description = <<EOT
  (Optional) The private subnet CIDR block.

  Default: "10.0.0.0/24"
  EOT
  default     = "10.0.0.0/24"
}

variable "private_subnet_id" {
  type        = string
  description = <<EOT
  (Optional) Private subnet ID

  Default: null
  EOT
  default     = null
}

variable "private_subnet_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags for the private subnets.

  Default: {}
  EOT
  default     = {}
}

variable "public_eni_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags to attach to the public ENI

  Default: {}
  EOT
  default     = {}
}

variable "public_key" {
  type        = string
  description = <<EOT
  (Optional) The public key material

  Default: ""
  EOT
  default     = ""
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
  (Optional) The public subnet CIDR block.

  Default: "10.0.1.0/24"
  EOT
  default     = "10.0.1.0/24"
}

variable "public_subnet_id" {
  type        = string
  description = <<EOT
  (Optional) Private subnet ID

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

variable "route_table_id" {
  type        = string
  description = <<EOT
  (Optional) Route table ID

  Default: null
  EOT
  default     = null
}

variable "s3bucket" {
  type        = string
  description = <<EOT
  (Optional) An S3 bucket in which to store configuration backups. If used in conjunction with "create_s3_bucket", this module will create the S3 bucket.

  Default: null
  EOT
  default     = null
}
variable "security_group_tags" {
  type        = map(string)
  description = <<EOT
  (Optional) Additional tags for the security group

  Default: {}
  EOT
  default     = {}
}

variable "serial_number" {
  type        = string
  description = <<EOT
  (Optional) The serial number of the firewall. Conflicts with PAYG SKU.

  Default: ""
  EOT
  default     = ""
}

variable "sfos_version" {
  type        = string
  description = <<EOT
  (Optional) The firmware version to use for the deployed firewall

  Available versions are:
  18.0 MR3
  18.0 MR4
  18.0 MR5
  18.5 MR1
  18.5 MR2
  18.5 MR3
  19.0 MR1

  Default: "latest"
  EOT
  default     = "latest"
  validation {
    condition     = contains(["latest", "18.0 MR3", "18.0 MR4", "18.0 MR5", "18.5 MR1", "18.5 MR2", "18.5 MR3"], var.sfos_version)
    error_message = <<EOT
    ERROR: Invalid version provided! Must be one of:
      latest
      18.0 MR3
      18.0 MR4
      18.0 MR5
      18.5 MR1
      18.5 MR2
      18.5 MR3
    EOT
  }
}

variable "secure_storage_master_key" {
  type        = string
  description = <<EOT
  (Optional) The Secure Storage Master Key password

  Default: null
  EOT
  default     = null
  validation {
    condition     = var.secure_storage_master_key == null || try(length(var.secure_storage_master_key) >= 10, true)
    error_message = <<EOT
    ERROR: Password must have at least 10 characters.
    EOT
  }
  validation {
    condition     = var.secure_storage_master_key == null || can(regex("[A-Z]", var.secure_storage_master_key))
    error_message = <<EOT
    ERROR: Password must contain at least one uppercase letter.
    EOT
  }
  validation {
    condition     = var.secure_storage_master_key == null || can(regex("[a-z]", var.secure_storage_master_key))
    error_message = <<EOT
    ERROR: Password must contain at least one lowercase letter.
    EOT
  }
  validation {
    condition     = var.secure_storage_master_key == null || can(regex("[^a-zA-Z0-9]", var.secure_storage_master_key))
    error_message = <<EOT
    ERROR: Password must contain at least one character that isn't a letter or a digit.
    EOT
  }
  validation {
    condition     = var.secure_storage_master_key == null || can(regex("[0-9]", var.secure_storage_master_key))
    error_message = <<EOT
    ERROR: Password must contain at least one digit.
    EOT
  }
}

variable "send_stats" {
  type        = string
  description = <<EOT
  (Required) Whether to Opt-in to Sophos customer telemetry
  EOT
  validation {
    condition     = contains(["on", "off"], var.send_stats)
    error_message = <<EOT
    ERROR: Send stats customer opt-in value must be one of: [on, off].
    EOT
  }
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
  (Required) The SKU to use for the AMI. Can be either payg or byol

  Default: payg
  EOT
  validation {
    condition     = contains(["payg", "byol"], var.sku)
    error_message = <<EOT
    ERROR: Invalid SKU provided! Must be one of: [payg, byol]
    EOT
  }
}

variable "ssh_key_name" {
  type        = string
  description = <<EOT
  (Optional) The name of the SSH key to use to authenticate to the firewall.

  Default: null
  EOT
  default     = null
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
  type        = string
  description = <<EOT
    (Required) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.

    The default behavior is to include the public IP address from which the Terraform plan is run.

    EG: 192.168.10.24/32
    EOT
  validation {
    condition = (
      can(cidrhost(var.trusted_ip, 0)) &&
      can(cidrnetmask(var.trusted_ip))
    )
    error_message = <<EOT
        ERROR: Must be a valid IPv4 CIDR block address.
        EOT
  }
}

variable "vpc_id" {
  type        = string
  description = <<EOT
  (Optional) The VPC ID to associate the subnet

  Default: null
  EOT
  default     = null
}

variable "vpc_tags" {
  type        = map(string)
  description = <<EOT
    (Optional) Additional tags to attach to the VPC

    Default: {}
    EOT
  default     = {}
}