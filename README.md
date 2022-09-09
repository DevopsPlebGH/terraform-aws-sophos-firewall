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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.29.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_network_interface.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route.public_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_secretsmanager_secret.centralpass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.sophospass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.ssmk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.xgconfig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.centralpass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.sophospass](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.ssmk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.xgconfig](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.lan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.sfos_byol](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami.sfos_payg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ec2_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2_iam_policy_central](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2_iam_policy_ssmk](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | XG Firewall admin console password | `string` | n/a | yes |
| <a name="input_central_password"></a> [central\_password](#input\_central\_password) | Sophos Central password | `string` | `""` | no |
| <a name="input_central_username"></a> [central\_username](#input\_central\_username) | Sophos Central username | `string` | `""` | no |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | CIDR range for the VPC CIDR block | `string` | `"172.16.0.0/16"` | no |
| <a name="input_config_password"></a> [config\_password](#input\_config\_password) | XG configuration password | `string` | n/a | yes |
| <a name="input_contact_email"></a> [contact\_email](#input\_contact\_email) | Contact email for the team or individual creating the resources | `string` | `null` | no |
| <a name="input_create_key_pair"></a> [create\_key\_pair](#input\_create\_key\_pair) | Determines whether resources will be created (affects all resources) | `bool` | `false` | no |
| <a name="input_create_private_key"></a> [create\_private\_key](#input\_create\_private\_key) | Determines whether a private key will be created | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | Controls if VPC should be created (it affects almost all resources) | `bool` | `true` | no |
| <a name="input_created_by"></a> [created\_by](#input\_created\_by) | Name of the person or identity that created the resource | `string` | `"terraform"` | no |
| <a name="input_default_security_group_egress"></a> [default\_security\_group\_egress](#input\_default\_security\_group\_egress) | List of maps of egress rules to set on the default security group | `list(map(string))` | `[]` | no |
| <a name="input_default_security_group_ingress"></a> [default\_security\_group\_ingress](#input\_default\_security\_group\_ingress) | List of maps of ingress rules to set on the default security group | `list(map(string))` | `[]` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Should be true to enable DNS hostnames in the VPC | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Should be true to enable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to be deployed. Must be one of: prod, dev, or stage. | `string` | `"dev"` | no |
| <a name="input_firewall_hostname"></a> [firewall\_hostname](#input\_firewall\_hostname) | Hostname of the firewall | `string` | `"sophos-xg-firewall"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type to use for the firewall | `map(any)` | <pre>{<br>  "large": "t3.large",<br>  "medium": "t3.medium",<br>  "small": "t3.small"<br>}</pre> | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The name for the key pair. Conflicts with `key_name_prefix` | `string` | `null` | no |
| <a name="input_key_name_prefix"></a> [key\_name\_prefix](#input\_key\_name\_prefix) | Creates a unique name beginning with the specified prefix. Conflicts with `key_name` | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the VPC | `string` | `"sophos.aws.demo_env"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace to identify the provisioned resources. Can be an app name, etc... | `string` | `"sophos"` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | The pre-fix to attach to created resources. | `string` | `"fw"` | no |
| <a name="input_private_key_algorithm"></a> [private\_key\_algorithm](#input\_private\_key\_algorithm) | Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519` | `string` | `"RSA"` | no |
| <a name="input_private_key_rsa_bits"></a> [private\_key\_rsa\_bits](#input\_private\_key\_rsa\_bits) | When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`) | `number` | `4096` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | Additional tags for the private route table | `map(string)` | `{}` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | CIDR block for private subnet | `string` | `"172.16.16.0/24"` | no |
| <a name="input_private_subnet_suffix"></a> [private\_subnet\_suffix](#input\_private\_subnet\_suffix) | Prefix to attach to private subnets | `string` | `"private"` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | The public key material | `string` | `""` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | CIDR block for public subnet | `string` | `"172.16.17.0/24"` | no |
| <a name="input_public_subnet_suffix"></a> [public\_subnet\_suffix](#input\_public\_subnet\_suffix) | Prefix to attach to public subnets | `string` | `"public"` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | Additional tags for the public subnets | `map(string)` | `{}` | no |
| <a name="input_region"></a> [region](#input\_region) | AWS Region in which to deploy the firewall | `string` | `null` | no |
| <a name="input_register_in_central"></a> [register\_in\_central](#input\_register\_in\_central) | Register firewall to Central | `bool` | `false` | no |
| <a name="input_secure_storage_master_key"></a> [secure\_storage\_master\_key](#input\_secure\_storage\_master\_key) | The Secure Storage Master Key | `string` | n/a | yes |
| <a name="input_send_stats"></a> [send\_stats](#input\_send\_stats) | Send telemetry to Sophos | `bool` | `true` | no |
| <a name="input_size"></a> [size](#input\_size) | Size of the firewall to deploy | `string` | `"medium"` | no |
| <a name="input_sophos_password"></a> [sophos\_password](#input\_sophos\_password) | Sophos Central password | `string` | `null` | no |
| <a name="input_suffix"></a> [suffix](#input\_suffix) | Suffix to attach to created resources | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_team"></a> [team](#input\_team) | The name of the team provisioning the resource | `string` | `null` | no |
| <a name="input_trusted_cidr"></a> [trusted\_cidr](#input\_trusted\_cidr) | Trusted IP address | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| <a name="input_vpc_prefix"></a> [vpc\_prefix](#input\_vpc\_prefix) | Pre-fix to attach to created VPC resources | `string` | `"vpc-"` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | Additional tags for the VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_key_pair_arn"></a> [key\_pair\_arn](#output\_key\_pair\_arn) | The key pair ARN |
| <a name="output_key_pair_fingerprint"></a> [key\_pair\_fingerprint](#output\_key\_pair\_fingerprint) | The MD5 public key fingerprint as specified in section 4 of RFC 4716 |
| <a name="output_key_pair_id"></a> [key\_pair\_id](#output\_key\_pair\_id) | The key pair ID |
| <a name="output_key_pair_name"></a> [key\_pair\_name](#output\_key\_pair\_name) | The key pair name |
| <a name="output_private_key_id"></a> [private\_key\_id](#output\_private\_key\_id) | Unique identifier for this resource: hexadecimal representation of the SHA1 checksum of the resource |
| <a name="output_private_key_openssh"></a> [private\_key\_openssh](#output\_private\_key\_openssh) | Private key data in OpenSSH PEM (RFC 4716) format |
| <a name="output_private_key_pem"></a> [private\_key\_pem](#output\_private\_key\_pem) | Private key data in PEM (RFC 1421) format |
| <a name="output_public_key_fingerprint_md5"></a> [public\_key\_fingerprint\_md5](#output\_public\_key\_fingerprint\_md5) | The fingerprint of the public key data in OpenSSH MD5 hash format, e.g. `aa:bb:cc:....` Only available if the selected private key format is compatible, similarly to `public_key_openssh` and the ECDSA P224 limitations |
| <a name="output_public_key_fingerprint_sha256"></a> [public\_key\_fingerprint\_sha256](#output\_public\_key\_fingerprint\_sha256) | The fingerprint of the public key data in OpenSSH SHA256 hash format, e.g. `SHA256:....` Only available if the selected private key format is compatible, similarly to `public_key_openssh` and the ECDSA P224 limitations |
| <a name="output_public_key_openssh"></a> [public\_key\_openssh](#output\_public\_key\_openssh) | The public key data in "Authorized Keys" format. This is populated only if the configured private key is supported: this includes all `RSA` and `ED25519` keys |
| <a name="output_public_key_pem"></a> [public\_key\_pem](#output\_public\_key\_pem) | Public key data in PEM (RFC 1421) format |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
