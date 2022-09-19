output "ami_map" {
  description = <<EOT
  The map of AMI's available.
  EOT
  value       = local.amis
}

output "azs" {
  description = <<EOT
  The availability zone that the resources were deployed in if no availability zone was specified.
  EOT
  value       = var.az == null ? var.az : element("${random_shuffle.az.result}", 0)
}

output "trusted_ips" {
  description = <<EOT
  The trusted IP CIDR's in the trusted IP security group.
  EOT
  value       = local.trusted_ip
}