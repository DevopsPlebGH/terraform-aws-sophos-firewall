output "private_key" {
  description = <<EOT
    SSH Private Key
    EOT
  value       = module.key-pair.private_key_pem
  sensitive   = true
}

output "public_ip" {
  description = <<EOT
    Firewalls public IP
    EOT
  value       = module.complete.firewall_ip_address
}

output "public_dns" {
  description = <<EOT
    Firewalls public DNS name
    EOT
  value       = module.complete.firewall_public_dns_name
}

output "availability_zone_map" {
  value = local.availability_zone_map
}

output "archive_name" {
  value = module.complete.lambda_archive
}

output "console_secret_arn" {
  value = module.complete.console_secret_arn
}
