variable "admin_password" {
  description = "XG Firewall admin console password"
  type        = string
  sensitive   = true
}

variable "central_password" {
  description = "Sophos Central password"
  type        = string
  sensitive   = true
  default     = null
}

variable "central_username" {
  description = "Sophos Central username"
  type        = string
  default     = ""
}

variable "cidr" {
  description = "CIDR range for the VPC CIDR block"
  type        = string
  default     = "172.16.0.0/16"
}

variable "config_password" {
  description = "XG configuration password"
  type        = string
  sensitive   = true
}

variable "contact_email" {
  description = "Contact email for the team or individual creating the resources"
  type        = string
  default     = null
}

variable "created_by" {
  description = "Name of the person or identity that created the resource"
  type        = string
  default     = "terraform"
}

variable "create_private_key" {
  description = "Determines whether a private key will be created"
  type        = bool
  default     = false
}

variable "create_key_pair" {
  description = "Determines whether resources will be created (affects all resources)"
  type        = bool
  default     = false
}

variable "default_security_group_egress" {
  description = "List of maps of egress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "default_security_group_ingress" {
  description = "List of maps of ingress rules to set on the default security group"
  type        = list(map(string))
  default     = []
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "environment" {
  description = "Environment to be deployed. Must be one of: prod, dev, or stage."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["prod", "dev", "stage"], var.environment)
    error_message = "ERROR: Environment must be one of: prod, dev, or stage."
  }
}

variable "firewall_hostname" {
  description = "Hostname of the firewall"
  type        = string
  default     = "sophos-xg-firewall"
}

variable "instance_type" {
  description = "EC2 instance type to use for the firewall"
  type        = map(any)
  default = {
    small  = "t3.small"
    medium = "t3.medium"
    large  = "t3.large"
  }
}

variable "key_name" {
  description = "The name for the key pair. Conflicts with `key_name_prefix`"
  type        = string
  default     = null
}

variable "key_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with `key_name`"
  type        = string
  default     = null
}

variable "name" {
  description = "The name of the VPC"
  type        = string
  default     = "sophos.aws.demo_env"
}

variable "namespace" {
  description = "Namespace to identify the provisioned resources. Can be an app name, etc..."
  type        = string
  default     = "sophos"
}

variable "prefix" {
  description = "The pre-fix to attach to created resources."
  type        = string
  default     = "fw"
}

variable "private_key_algorithm" {
  description = "Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519`"
  type        = string
  default     = "RSA"
}

variable "private_key_rsa_bits" {
  description = "When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`)"
  type        = number
  default     = 4096
}

variable "private_subnet" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "172.16.16.0/24"
}

variable "private_subnet_prefix" {
  description = "Prefix to attach to private subnets"
  type        = string
  default     = "private-subnet-"
}

variable "public_key" {
  description = "The public key material"
  type        = string
  default     = ""
}

variable "public_subnet" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "172.16.17.0/24"
}

variable "public_subnet_prefix" {
  description = "Prefix to attach to public subnets"
  type        = string
  default     = "public-subnet-"
}

variable "region" {
  description = "AWS Region in which to deploy the firewall"
  type        = string
  default     = null
}

variable "register_in_central" {
  description = "Register firewall to Central"
  type        = bool
  default     = false
}

variable "secure_storage_master_key" {
  description = "The Secure Storage Master Key"
  type        = string
  sensitive   = true
}

variable "send_stats" {
  description = "Send telemetry to Sophos"
  type        = bool
  default     = true
}

variable "size" {
  description = "Size of the firewall to deploy"
  type        = string
  default     = "medium"
}

variable "sophos_password" {
  description = "Sophos Central password"
  type        = string
  sensitive   = true
  default     = null
}

variable "suffix" {
  description = "Suffix to attach to created resources"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "team" {
  description = "The name of the team provisioning the resource"
  type        = string
  default     = null
}

variable "trusted_cidr" {
  description = "Trusted IP address"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vpc_prefix" {
  description = "Pre-fix to attach to created VPC resources"
  type        = string
  default     = "vpc-"
}
