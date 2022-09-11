output "public_ip" {
  description = "Firewall Webconsole IP Address"
  value       = try(aws_eip.this.*.public_ip, "")
}
