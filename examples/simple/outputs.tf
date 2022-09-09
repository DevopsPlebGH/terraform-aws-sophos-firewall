output "public_ip" {
  value = module.example-basic.public_ip
}

output "key_pair_id" {
  value = module.key-pair.key_pair_id
}

output "key_pair_arn" {
  value = module.key-pair.key_pair_arn
}

output "key_pair_name" {
  value = module.key-pair.key_pair_name
}

output "private_key_pem" {
  value     = module.key-pair.private_key_pem
  sensitive = true
}
