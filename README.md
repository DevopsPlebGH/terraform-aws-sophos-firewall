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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.30.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_network_interface.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_secretsmanager_secret.config_backup_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.console_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.config_backup_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.console_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.lan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [random_shuffle.az](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/shuffle) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ec2_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az"></a> [az](#input\_az) | (Optional) The availability zone in which to deploy the firewall.<br><br>  If not defined, this value will be derived from a randomly selected AZ via the aws\_availability\_zones data source.<br><br>  Default: "" | `string` | `null` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The CIDR range for the VPC CIDR block.<br><br>    Default: "10.0.0.0/16" | `string` | `"10.0.0.0/16"` | no |
| <a name="input_config_backup_password"></a> [config\_backup\_password](#input\_config\_backup\_password) | (Required) The password to secure the configuration backup. | `string` | n/a | yes |
| <a name="input_console_password"></a> [console\_password](#input\_console\_password) | (Required) The password for the firewall management console. | `string` | n/a | yes |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | (Optional) Controls whether or not a new VPC should be created or if an existing VPC should be used.<br><br>    Default: true | `bool` | `"true"` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) Controls whether or not DNS hostname support should be enabled in the VPC<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) Controls whether DNS support should be enabled in the VPC<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | (Optional) Additional tags to attach to created IAM roles<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_internet_gateway_tags"></a> [internet\_gateway\_tags](#input\_internet\_gateway\_tags) | (Optional) Additional tags to attach to created internet gateways<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Optional) Namespace refers to the application or deployment type.<br><br>    EG: sophos-xg, sophos-optix, sophos-cwp, etc...<br><br>    Default: sophos-xg | `string` | `"sophos-xg"` | no |
| <a name="input_private_eni_tags"></a> [private\_eni\_tags](#input\_private\_eni\_tags) | (Optional) Additional tags to attach to the private ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | (Optional) Additional tags to attach to the public route table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | (Optional) The CIDR block of the private subnet. Conflicts with subnet\_prefix<br><br>  Default: null | `string` | `null` | no |
| <a name="input_public_eni_tags"></a> [public\_eni\_tags](#input\_public\_eni\_tags) | (Optional) Additional tags to attach to the public ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | (Optional) Additional tags to attach to the Public Route Table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | (Optional) The CIDR block of the public subnet. Conflicts with subnet\_prefix.<br><br>  Default: null | `string` | `null` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | (Optional) Additional tags for the public subnets.<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | (Optional) Additional tags to attach to security groups<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | (Optional) The subnet prefix. Conflicts with public\_subnet/private\_subnet.<br><br>  Default: "24" | `string` | `"24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources<br><br>    Default: {} | `map(string)` | `{}` | no |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | (Optional) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.<br><br>    The default behavior is to include the public IP address from which the Terraform plan is run.<br><br>    EG: 192.168.10.24/32<br><br>    Default: [null] | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | (Optional) Additional tags to attach to the VPC<br><br>    Default: {} | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azs"></a> [azs](#output\_azs) | The availability zone that the resources were deployed in if no availability zone was specified. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
