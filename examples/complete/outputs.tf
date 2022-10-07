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
output "console_secret_name" {
  value = module.complete.console_secret_name
}
