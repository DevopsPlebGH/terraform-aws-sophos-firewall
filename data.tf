data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}
data "aws_ami" "sfos_byol" {
  most_recent = true
  filter {
    name   = "description"
    values = ["XG on AWS *-byol"]
  }
}

data "aws_ami" "sfos_payg" {
  most_recent = true
  filter {
    name   = "description"
    values = ["XG on AWS *-payg"]
  }
}

data "aws_iam_policy_document" "ec2_iam_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      aws_secretsmanager_secret.sophospass.arn,
      aws_secretsmanager_secret.xgconfig.arn
    ]
  }
}

data "aws_iam_policy_document" "ec2_iam_policy_central" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      aws_secretsmanager_secret.centralpass.arn
    ]
  }
}

data "aws_iam_policy_document" "ec2_iam_policy_ssmk" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      aws_secretsmanager_secret.ssmk.arn
    ]
  }
}

data "aws_iam_policy_document" "trust_relationship" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")
  vars = {
    ssmk_password     = var.secure_storage_master_key
    central_username  = var.central_username
    central_password  = var.central_password
    firewall_hostname = var.firewall_hostname
    send_stats        = var.send_stats
    aws_region        = var.region != null ? var.region : data.aws_region.current.name
    admin_password    = var.admin_password
    config_password   = var.config_password
  }
}
