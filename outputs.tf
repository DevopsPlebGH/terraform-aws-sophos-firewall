output "ami_id" {
  value = local.sfos_ami
}

output "ami_map" {
  description = <<EOT
  The map of AMI's available.
  EOT
  value       = local.amis
}

output "availability_zones" {
  description = <<EOT
  The availability zone that the resources were deployed in if no availability zone was specified.
  EOT
  value       = var.availability_zone != null ? var.availability_zone : data.aws_availability_zones.available.names[0]
}

output "console_secret_name" {
  description = <<EOT
  The ARN for the Console Secret.
  EOT
  value       = aws_secretsmanager_secret.console_password.name
}
output "firewall_ip_address" {
  description = <<EOT
  The public IP for the firewall
  EOT
  value       = aws_eip.this.*.public_ip
}

output "firewall_public_dns_name" {
  description = <<EOT
  The public DNS name for the firewall.
  EOT
  value       = aws_instance.this.public_dns
}

output "template_file" {
  value = data.template_file.user_data.rendered
}

output "lambda_archive" {
  value = data.archive_file.lambda_zip.id
}
