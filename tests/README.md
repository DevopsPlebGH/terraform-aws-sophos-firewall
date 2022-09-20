# tests

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ami.xg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami_ids.sfos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_sfos_version"></a> [sfos\_version](#input\_sfos\_version) | (Optional) The firmware version to use for the deployed firewall<br><br>  Default: "latest" | `string` | `"latest"` | no |
| <a name="input_sfos_versions"></a> [sfos\_versions](#input\_sfos\_versions) | (Optional) Version of SFOS firmware to use with the EC2 instance<br><br>    Default: "" | `map(any)` | <pre>{<br>  "18.0 MR3": "18.0.3.457",<br>  "18.0 MR4": "18.0.4.506",<br>  "18.0 MR5": "18.0.5.585",<br>  "18.5 MR1": "18.5.1.326",<br>  "18.5 MR2": "18.5.2.380",<br>  "18.5 MR3": "18.5.3.408",<br>  "latest": "19.0.0.317"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami"></a> [ami](#output\_ami) | n/a |
| <a name="output_locals"></a> [locals](#output\_locals) | n/a |
| <a name="output_sfos_version"></a> [sfos\_version](#output\_sfos\_version) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
