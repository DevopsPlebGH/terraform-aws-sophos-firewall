variable "cidr_block" {
  type        = string
  description = <<EOT
    (Optional) The CIDR range for the VPC CIDR block.

    Default: "10.0.0.0/16"
    EOT
  default     = "10.0.0.0/16"
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

variable "namespace" {
  type        = string
  description = <<EOT
    (Optional) Namespace refers to the application or deployment type.
    
    EG: sophos-xg, sophos-optix, sophos-cwp, etc...

    default: sophos-xg
    EOT
  default     = "sophos-xg"
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