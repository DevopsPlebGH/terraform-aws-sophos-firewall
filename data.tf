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

data "aws_eip" "by_filter" {
  depends_on = [aws_eip.this]
  filter {
    name   = "tag:Name"
    values = ["${local.name_prefix}"]
  }
}

// EC2 IAM role
data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = var.central_password == null ? [] : [1]
    content {
      sid = "CentralPass"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [aws_secretsmanager_secret.central_password.arn]
    }
  }
  dynamic "statement" {
    for_each = var.console_password == null ? [] : [1]
    content {
      sid = "ConsolePass"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [aws_secretsmanager_secret.console_password.arn]
    }
  }
  dynamic "statement" {
    for_each = var.config_backup_password == null ? [] : [1]
    content {
      sid = "ConfigBackupPass"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [aws_secretsmanager_secret.config_backup_password.arn]
    }
  }
  dynamic "statement" {
    for_each = var.secure_storage_master_key == null ? [] : [1]
    content {
      sid = "SecureStorageMasterKey"
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = [aws_secretsmanager_secret.secure_storage_master_key.arn]
    }
  }
}