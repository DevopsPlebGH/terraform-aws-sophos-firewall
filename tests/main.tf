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
  amis = { for k, v in data.aws_ami.xg : k => v.description }
}

output "locals" {
  value = local.amis
}

output "ami" {
  value = [for k, v in local.amis : k if v == "XG on AWS 18.0.3.457-payg"]
}