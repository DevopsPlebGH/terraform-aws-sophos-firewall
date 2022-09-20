variable "config_backup_password" {
  type        = string
  description = <<EOT
  (Required) The password to secure the configuration backup.

  EOT
}

variable "console_password" {
  type        = string
  description = <<EOT
    (Required) The password for the firewall management console.
    EOT
}

variable "secure_storage_master_key" {
  type        = string
  description = <<EOT
  (Required) The Secure Storage Master Key password.
  EOT
}