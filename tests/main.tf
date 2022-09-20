provider "aws" {}

data "aws_ami_ids" "sfos" {
  owners = ["aws-marketplace"]
  filter {
    name   = "name"
    values = ["sophos_xg*"]
  }
}

data "aws_ami" "xg" {
  for_each = toset(data.aws_ami_ids.sfos.ids)
  owners   = ["aws-marketplace"]
  filter {
    name   = "image-id"
    values = [each.key]
  }
}

locals {
  amis         = { for k, v in data.aws_ami.xg : k => v.description }
  sfos_version = lookup(var.sfos_versions, var.sfos_version)
  ami          = [for k, v in local.amis : k if v == "XG on AWS ${local.sfos_version}-payg"]
}


output "locals" {
  value = local.amis
}

output "ami" {
  value = local.ami
}

output "sfos_version" {
  value = local.sfos_version
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