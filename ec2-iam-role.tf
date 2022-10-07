#################
#     EC2 IAM Role      #
#################
locals {
  create_date = formatdate("MM-DD-YYYY", timestamp())
  name_prefix = "${random_id.this.hex}-"
  default_tags = {
    managed_by_terraform = "True"
    app                  = var.app != "" ? var.app : var.app
    environment          = var.environment != "" ? var.environment : "dev"
    firewall_sku         = var.sku != "" ? var.sku : "payg"
  }
}
# EC2 IAM role that's attached to the EC2 instance profile. This role allows the EC2 instance permission to access the Secrets Service Manager secrets for the firewalls initial configuration.
resource "aws_iam_role" "ec2_iam_role" {
  name               = "ec2-iam-role-${random_id.this.hex}-${data.aws_caller_identity.current.account_id}"
  assume_role_policy = data.aws_iam_policy_document.trust_relationship.json
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  tags = merge(
    { deploy_date = local.create_date },
    local.default_tags,
    var.iam_role_tags,
    var.tags
  )
}

## Secure Storage Secrets Master Password ##
# SSM Secure Storage Master Key Policy Document
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
# SSM Secure Storage Master Key Policy
resource "aws_iam_role_policy" "secure_storage_master_key" {
  name   = "${local.name_prefix}secure_storage_master_key"
  role   = aws_iam_role.ec2_iam_role.id
  policy = data.aws_iam_policy_document.secure_storage_master_key.json
}
# SSM Secure Storage Master Key Policy Attachment
resource "aws_iam_policy_attachment" "secure_storage_master_key" {
  name       = "${local.name_prefix}secure_storage_master_key_attachment"
  roles      = [aws_iam_role.ec2_iam_role.name]
  policy_arn = aws_iam_role_policy.secure_storage_master_key.arn
}

## Firewall Console Password ##
# SSM Firewall Console Password Secret Policy Document
data "aws_iam_policy_document" "firewall_console_password" {
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
# SSM Firewall Console Password Policy
resource "aws_iam_role_policy" "firewall_console_password" {
  name   = "${local.name_prefix}firewall_console_password"
  role   = aws_iam_role.ec2_iam_role.id
  policy = data.aws_iam_policy_document.firewall_console_password.json
}
# SSM Firewall Console Password Policy Attachment
resource "aws_iam_policy_attachment" "firewall_console_password" {
  name       = "${local.name_prefix}firewall_console_password_attachment"
  roles      = [aws_iam_role.ec2_iam_role.name]
  policy_arn = aws_iam_role_policy.firewall_console_password.arn
}

## Sophos Central Password ##
# SSM Sophos Central Password Secrets Policy Document
data "aws_iam_policy_document" "sophos_central_password" {
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
# SSM Sophos Central Password Policy
resource "aws_iam_role_policy" "secret_central_password" {
  count  = var.central_password != "" ? 1 : 0
  name   = "${local.name_prefix}sophos_central_password"
  role   = aws_iam_role.ec2_iam_role.id
  policy = data.aws_iam_policy_document.sophos_central_password[0].json
}
# SSM Sophos Central Password Policy Attachment
resource "aws_iam_policy_attachment" "sophos_central_password" {
  name       = "${local.name_prefix}sophos_central_password_attachment"
  roles      = [aws_iam_role.ec2_iam_role.name]
  policy_arn = aws_iam_role_policy.secret_central_password.arn
}
