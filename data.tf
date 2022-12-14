data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/xg-config-lambda"
  output_path = "${path.module}/initial_config.zip"
}
data "aws_ami_ids" "sfos" {
  owners = ["aws-marketplace"]
  filter {
    name   = "name"
    values = ["sophos_xg*"]
  }
}

data "aws_ami" "dynamic_ami" {
  for_each    = toset(data.aws_ami_ids.sfos.ids)
  owners      = ["aws-marketplace"]
  most_recent = var.autodetect == true ? var.autodetect : null
  filter {
    name   = "image-id"
    values = [each.key]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_caller_identity" "current" {}

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

data "aws_region" "current" {}

data "template_file" "user_data" {
  template = file("${path.module}/templates/user_data.tpl")
  vars = {
    ssmkSecretId    = aws_secretsmanager_secret.secure_storage_master_key.arn
    s3bucket        = var.s3bucket
    centralusername = var.central_username
    centralpassword = var.central_password != "" ? aws_secretsmanager_secret.central_password[0].arn : null
    hostname        = var.firewall_hostname
    sendstats       = var.send_stats
    region          = var.aws_region
    secretId        = aws_secretsmanager_secret.console_password.arn
    configSecretId  = aws_secretsmanager_secret.config_backup_password.arn
    serialKey       = var.serial_number
  }
}

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}
