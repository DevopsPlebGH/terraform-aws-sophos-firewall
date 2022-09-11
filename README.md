# terraform-aws-sophos-firewall

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The CIDR range for the VPC CIDR block.<br><br>    Default: "10.0.0.0/16" | `string` | `"10.0.0.0/16"` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | (Optional) Controls whether or not a new VPC should be created or if an existing VPC should be used.<br><br>    Default: true | `bool` | `"true"` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) Controls whether or not DNS hostname support should be enabled in the VPC<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) Controls whether DNS support should be enabled in the VPC<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) Namespace refers to the application or deployment type.<br><br>    EG: sophos-xg, sophos-optix, sophos-cwp, etc...<br><br>    default: sophos-xg | `string` | `"sophos-xg"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources<br><br>    Default: {} | `map(string)` | `{}` | no |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | (Optional) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.<br><br>    The default behavior is to include the public IP address from which the Terraform plan is run.<br><br>    EG: 192.168.10.24/32<br><br>    Default: [null] | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | (Optional) Additional tags to attach to the VPC<br><br>    Default: {} | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
