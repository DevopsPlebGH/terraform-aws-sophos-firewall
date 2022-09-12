# terraform-cidr-subnets

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.10 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_cidr_block"></a> [base\_cidr\_block](#input\_base\_cidr\_block) | A network address prefix in CIDR notation that all of the requested subnetwork prefixes will be allocated within. | `string` | n/a | yes |
| <a name="input_networks"></a> [networks](#input\_networks) | A list of objects describing requested subnetwork prefixes. new\_bits is the number of additional network prefix bits to add, in addition to the existing prefix on base\_cidr\_block. | <pre>list(object({<br>    name     = string<br>    new_bits = number<br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_base_cidr_block"></a> [base\_cidr\_block](#output\_base\_cidr\_block) | Echoes back the base\_cidr\_block input variable value, for convenience if passing the result of this module elsewhere as an object. |
| <a name="output_network_cidr_blocks"></a> [network\_cidr\_blocks](#output\_network\_cidr\_blocks) | A map from network names to allocated address prefixes in CIDR notation. |
| <a name="output_networks"></a> [networks](#output\_networks) | A list of objects corresponding to each of the objects in the input variable 'networks', each extended with a new attribute 'cidr\_block' giving the network's allocated address prefix. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
