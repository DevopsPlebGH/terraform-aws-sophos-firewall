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

output "trusted_ips" {
  description = <<EOT
  The trusted IP CIDR's in the trusted IP security group.
  EOT
  value       = local.trusted_cidrs
}

output "firewall_ip_address" {
  description = <<EOT
  The public IP for the firewall
  EOT
  value       = aws_instance.this.public_ip
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

output "cicd_ip" {
  value = local.cicd_ip
}