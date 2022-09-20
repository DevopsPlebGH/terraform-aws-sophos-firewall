# simple

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_complete"></a> [complete](#module\_complete) | ../../ | n/a |
| <a name="module_key-pair"></a> [key-pair](#module\_key-pair) | terraform-aws-modules/key-pair/aws | 2.0.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_config_backup_password"></a> [config\_backup\_password](#input\_config\_backup\_password) | (Required) The password to secure the configuration backup. | `string` | n/a | yes |
| <a name="input_console_password"></a> [console\_password](#input\_console\_password) | (Required) The password for the firewall management console. | `string` | n/a | yes |
| <a name="input_secure_storage_master_key"></a> [secure\_storage\_master\_key](#input\_secure\_storage\_master\_key) | (Required) The Secure Storage Master Key password. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
