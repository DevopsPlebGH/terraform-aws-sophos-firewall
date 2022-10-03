# simple

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.32.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../../ | n/a |
| <a name="module_key-pair"></a> [key-pair](#module\_key-pair) | terraform-aws-modules/key-pair/aws | 2.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_availability_zone.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zone) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_backup_password"></a> [config\_backup\_password](#input\_config\_backup\_password) | (Required) The password to secure the configuration backup. | `string` | n/a | yes |
| <a name="input_console_password"></a> [console\_password](#input\_console\_password) | (Required) The password for the firewall management console. | `string` | n/a | yes |
| <a name="input_secure_storage_master_key"></a> [secure\_storage\_master\_key](#input\_secure\_storage\_master\_key) | (Required) The Secure Storage Master Key password. | `string` | n/a | yes |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | (Required) Trusted IP to allow access to the firewall console. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_archive_name"></a> [archive\_name](#output\_archive\_name) | n/a |
| <a name="output_availability_zone_map"></a> [availability\_zone\_map](#output\_availability\_zone\_map) | n/a |
| <a name="output_console_secret_arn"></a> [console\_secret\_arn](#output\_console\_secret\_arn) | n/a |
| <a name="output_private_key"></a> [private\_key](#output\_private\_key) | SSH Private Key |
| <a name="output_public_dns"></a> [public\_dns](#output\_public\_dns) | Firewalls public DNS name |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Firewalls public IP |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
