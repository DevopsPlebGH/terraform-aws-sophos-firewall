data "aws_ami_ids" "sfos" {
  owners = ["aws-marketplace"]
  filter {
    name   = "name"
    values = ["sophos_xg*"]
  }
}

data "aws_ami" "sfos" {
  for_each    = toset(data.aws_ami_ids.sfos.ids)
  owners      = ["aws-marketplace"]
  most_recent = var.latest == true ? var.latest : null
  filter {
    name   = "image-id"
    values = [each.key]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

data "aws_iam_policy_document" "central" {
  count = var.central_password != "" ? 1 : 0
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      element(aws_secretsmanager_secret.central_password[*].arn, count.index)
    ]
  }
}

data "aws_iam_policy_document" "ec2_iam_policy" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      aws_secretsmanager_secret.console_password.arn,
      aws_secretsmanager_secret.config_backup_password.arn
    ]
  }
}

data "aws_iam_policy_document" "secure_storage_master_key" {
  statement {
    actions = [
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret"
    ]
    resources = [
      aws_secretsmanager_secret.secure_storage_master_key.arn
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