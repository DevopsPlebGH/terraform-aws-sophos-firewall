#########################
#  AWS Secrets Manager Secrets #
#########################
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

## XG Console Password ##
# Variable
variable "console_password" {
  type        = string
  description = <<EOT
  (Required) The password for the firewall management console.
  EOT
  validation {
    condition     = can(regex("^(.*[0-9])(.*[^A-Za-z0-9])(.*[a-z])(.*[A-Z])((.*)).{10,60}$", var.console_password))
    error_message = <<EOT
    ERROR: Password validation error.

    Password does not meet the password complexity requirements. Password must be;
    At least 10 characters long, have at least one upper case and one lower case letter, at least one number, and at least one special character.
    EOT
  }
}
# Secret
resource "aws_secretsmanager_secret" "BasicAdminPassword" {
  # checkov:skip=BC_AWS_GENERAL_79: Using default KMS Key ID. Will add customer managed KMS key.
  name                    = "${local.name_prefix}BasicAdminPassword"
  description             = <<EOT
  XG Firewall Console Password
  EOT
  recovery_window_in_days = 0
}
# Secret Version
resource "aws_secretsmanager_secret_version" "BasicAdminPassword" {
  secret_id     = aws_secretsmanager_secret.BasicAdminPassword.id
  secret_string = var.console_password
}

## Configuration Backup Password ##
# Variable
variable "config_backup_password" {
  type        = string
  description = <<EOT
  (Required) The password to secure the configuration backup.
  EOT
  validation {
    condition     = can(regex("^(.*[0-9])(.*[^A-Za-z0-9])(.*[a-z])(.*[A-Z])((.*)).{10,60}$", var.console_password))
    error_message = <<EOT
    ERROR: Password validation error.

    Password does not meet the password complexity requirements. Password must be;
    At least 10 characters long, have at least one upper case and one lower case letter, at least one number, and at least one special character.
    EOT
  }
}
# Secret
resource "aws_secretsmanager_secret" "ConfigBackupPassword" {
  # checkov:skip=BC_AWS_GENERAL_79: Using default KMS Key ID. Will add customer managed KMS key.
  name                    = "${local.name_prefix}ConfigBackupPassword"
  description             = <<EOT
  Firewall backup configuration password.
  EOT
  recovery_window_in_days = 0
}
# Secret Version
resource "aws_secretsmanager_secret_version" "ConfigBackupPassword" {
  secret_id     = aws_secretsmanager_secret.ConfigBackupPassword.id
  secret_string = var.config_backup_password
}

## Secure Storage Secrets Master Key ##
# Variable
variable "secure_storage_master_key" {
  type        = string
  description = <<EOT
  (Required) The Secure Storage Master Key password.
  EOT
  validation {
    condition     = can(regex("^(.*[0-9])(.*[^A-Za-z0-9])(.*[a-z])(.*[A-Z])((.*)).{10,60}$", var.console_password))
    error_message = <<EOT
    ERROR: Password validation error.

    Password does not meet the password complexity requirements. Password must be;
    At least 10 characters long, have at least one upper case and one lower case letter, at least one number, and at least one special character.
    EOT
  }
}
# Secret
resource "aws_secretsmanager_secret" "SSMKPassword" {
  # checkov:skip=BC_AWS_GENERAL_79: Using default KMS Key ID. Will add customer managed KMS key.
  name                    = "${local.prefix_name}SSMKPassword"
  description             = <<EOT
  Secure Storage Master Key password.
  EOT
  recovery_window_in_days = 0
}
# Secret Version
resource "aws_secretsmanager_secret_version" "SSMKPassword" {
  secret_id     = aws_secretsmanager_secret.SSMKPassword.id
  secret_string = var.secure_storage_master_key
}

## Central Username ##
# Secret
resource "aws_secretsmanager_secret" "CentralUsername" {}
# Secret Version
resource "aws_secretsmanager_secret" "CentralUsername" {}

## Central Password ##
# Secret
resource "aws_secretsmanager_secret" "CentralPassword" {}
# Secret Version
resource "aws_secretsmanager_secret_version" "CentralPassword" {}
