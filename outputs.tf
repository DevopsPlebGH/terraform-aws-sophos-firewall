output "azs" {
  description = <<EOT
  The availability zone that the resources were deployed in if no availability zone was specified.
  EOT
  value       = var.az == null ? var.az : element("${random_shuffle.az.result}", 0)
}
