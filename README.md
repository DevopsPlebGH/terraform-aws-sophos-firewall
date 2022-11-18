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
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.32.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_iam_instance_profile.xg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.xg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.xg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_launch_template.xg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_network_interface.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_network_interface.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface) | resource |
| [aws_route.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_secretsmanager_secret.central_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.config_backup_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.console_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.secure_storage_master_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.central_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.config_backup_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.console_password](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.secure_storage_master_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.lan](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.trusted](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.dynamic_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami_ids.sfos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids) | data source |
| [aws_eip.by_filter](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eip) | data source |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accept_eula"></a> [accept\_eula](#input\_accept\_eula) | (Required) Use of this software is subject to the Sophos End User License Agreement (EULA) at https://www.sophos.com/en-us/legal/sophos-end-user-license-agreement.aspx. You must enter 'yes' to accept the EULA to continue, so please read it carefully. You also acknowledge that Sophos processes personal data in accordance with the Sophos Privacy Policy at https://www.sophos.com/en-us/legal/sophos-group-privacy-notice.aspx | `string` | n/a | yes |
| <a name="input_app"></a> [app](#input\_app) | (Optional) Sophos XG Deployment type: HA, Standalone, autoscaling<br><br>  Default: null | `string` | `null` | no |
| <a name="input_autodetect"></a> [autodetect](#input\_autodetect) | (Optional) Whether or not to use the latest version of the AMI.<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Required) The availability zone in which to deploy the firewall. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | (Required) The region in which to deploy the firewall | `string` | n/a | yes |
| <a name="input_central_password"></a> [central\_password](#input\_central\_password) | (Optional) The password for your Sophos Central account if you would like to register the firewall with Sophos Central<br><br>  Default: null | `string` | `null` | no |
| <a name="input_central_username"></a> [central\_username](#input\_central\_username) | (Optional) Sophos Central username if registering the firewall to Central<br><br>  Default: null | `string` | `null` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The CIDR range for the VPC CIDR block.<br><br>    Default: "10.0.0.0/16" | `string` | `"10.0.0.0/16"` | no |
| <a name="input_config_backup_password"></a> [config\_backup\_password](#input\_config\_backup\_password) | (Required) The password to secure the configuration backup. | `string` | n/a | yes |
| <a name="input_console_password"></a> [console\_password](#input\_console\_password) | (Required) The password for the firewall management console. | `string` | n/a | yes |
| <a name="input_create_elastic_ip"></a> [create\_elastic\_ip](#input\_create\_elastic\_ip) | (Optional) If set to false, an existing elastic IP allocation ID will need to be provided. | `bool` | `true` | no |
| <a name="input_create_key_pair"></a> [create\_key\_pair](#input\_create\_key\_pair) | (Optional) Determines whether resources will be created (affects all resources)<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_create_private_key"></a> [create\_private\_key](#input\_create\_private\_key) | (Optional) Determines whether a private key will be created<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_create_s3_bucket"></a> [create\_s3\_bucket](#input\_create\_s3\_bucket) | (Optional) Whether or not an S3 bucket should be created for the firewall configuration backups.<br><br>  Default: false | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | (Optional) If set to false, an existing VPC ID and existing subnet ID's will need to be provided.<br><br>    Default: false | `bool` | `false` | no |
| <a name="input_elastic_ip_tags"></a> [elastic\_ip\_tags](#input\_elastic\_ip\_tags) | (Optional) Additional tags to attach to the Elastic IP Address<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) Controls whether or not DNS hostname support should be enabled in the VPC<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) Controls whether DNS support should be enabled in the VPC<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | (Optional) ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'dev', 'stage'<br><br>  Default: null | `string` | `null` | no |
| <a name="input_firewall_hostname"></a> [firewall\_hostname](#input\_firewall\_hostname) | (Optional) The hostname of the firewall<br><br>  Default: "sophos-firewall-tf" | `string` | `"sophos-firewall-tf"` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | (Optional) Map of additional tags to attach to the IAM role<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_profile_tags"></a> [instance\_profile\_tags](#input\_instance\_profile\_tags) | (Optional) Map of additional tags to attach to the Instance Profile<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | (Required) The size of the instance to deploy. Available instance sizes are:<br><br>    t3.small<br>    t3.medium<br>    m3.xlarge<br>    m3.2xlarge<br>    m4.large<br>    m4.xlarge<br>    m5.large<br>    m5.xlarge<br>    m5.2xlarge<br>    c3.xlarge<br>    c3.2xlarge<br>    c3.4xlarge<br>    c3.8xlarge<br>    c4.large<br>    c4.xlarge<br>    c4.2xlarge<br>    c4.4xlarge<br>    c4.8xlarge<br>    c5.large<br>    c5.xlarge<br>    c5.2xlarge<br><br>  Default: "m5.large" | `string` | n/a | yes |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | (Optional) Additional tags to attach to the EC2 instance<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional) The EC2 instance type to use for the firewall | `map(any)` | <pre>{<br>  "c3.2xlarge": "c3.2xlarge",<br>  "c3.4xlarge": "c3.4xlarge",<br>  "c3.8xlarge": "c3.8xlarge",<br>  "c3.xlarge": "c3.xlarge",<br>  "c4.2xlarge": "c4.2xlarge",<br>  "c4.4xlarge": "c4.4xlarge",<br>  "c4.8xlarge": "c4.8xlarge",<br>  "c4.large": "c4.large",<br>  "c4.xlarge": "c4.xlarge",<br>  "c5.2xlarge": "c5.2xlarge",<br>  "c5.large": "c5.large",<br>  "c5.xlarge": "c5.xlarge",<br>  "m3.2xlarge": "m3.2xlarge",<br>  "m3.xlarge": "m3.xlarge",<br>  "m4.large": "m4.large",<br>  "m4.xlarge": "m4.xlarge",<br>  "m5.2xlarge": "m5.2xlarge",<br>  "m5.large": "m5.large",<br>  "m5.xlarge": "m5.xlarge",<br>  "t3.medium": "t3.medium",<br>  "t3.small": "t3.small"<br>}</pre> | no |
| <a name="input_internet_gateway_tags"></a> [internet\_gateway\_tags](#input\_internet\_gateway\_tags) | (Optional) Additional tags to attach to created internet gateways<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_launch_template_tags"></a> [launch\_template\_tags](#input\_launch\_template\_tags) | (Optional) Additional tags to attach to the launch template<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | (Optional) ID element. Usually an abbreviation of your organization name to help ensure generated ID's are globally unique.<br><br>  Default: null | `string` | `null` | no |
| <a name="input_network_interface_id"></a> [network\_interface\_id](#input\_network\_interface\_id) | (Optional) Network Interface ID<br><br>  Default: null | `string` | `null` | no |
| <a name="input_private_eni_tags"></a> [private\_eni\_tags](#input\_private\_eni\_tags) | (Optional) Additional tags to attach to the private ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_key_algorithm"></a> [private\_key\_algorithm](#input\_private\_key\_algorithm) | (Optional) Name of the algorithm to use when generating the private key. Currently-supported values are `RSA` and `ED25519`<br><br>  Default: RSA | `string` | `"RSA"` | no |
| <a name="input_private_key_rsa_bits"></a> [private\_key\_rsa\_bits](#input\_private\_key\_rsa\_bits) | When algorithm is `RSA`, the size of the generated RSA key, in bits (default: `4096`) | `number` | `4096` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | (Optional) Additional tags to attach to the Private Route Table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | (Optional) The private subnet CIDR block.<br><br>  Default: "10.0.0.0/24" | `string` | `"10.0.0.0/24"` | no |
| <a name="input_private_subnet_id"></a> [private\_subnet\_id](#input\_private\_subnet\_id) | (Optional) Private subnet ID<br><br>  Default: null | `string` | `null` | no |
| <a name="input_private_subnet_tags"></a> [private\_subnet\_tags](#input\_private\_subnet\_tags) | (Optional) Additional tags for the private subnets.<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_eni_tags"></a> [public\_eni\_tags](#input\_public\_eni\_tags) | (Optional) Additional tags to attach to the public ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_key"></a> [public\_key](#input\_public\_key) | (Optional) The public key material<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | (Optional) Additional tags to attach to the Public Route Table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | (Optional) The public subnet CIDR block.<br><br>  Default: "10.0.1.0/24" | `string` | `"10.0.1.0/24"` | no |
| <a name="input_public_subnet_id"></a> [public\_subnet\_id](#input\_public\_subnet\_id) | (Optional) Private subnet ID<br><br>  Default: null | `string` | `null` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | (Optional) Additional tags for the public subnets.<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_route_table_id"></a> [route\_table\_id](#input\_route\_table\_id) | (Optional) Route table ID<br><br>  Default: null | `string` | `null` | no |
| <a name="input_s3bucket"></a> [s3bucket](#input\_s3bucket) | (Optional) An S3 bucket in which to store configuration backups. If used in conjunction with "create\_s3\_bucket", this module will create the S3 bucket.<br><br>  Default: null | `string` | `null` | no |
| <a name="input_secure_storage_master_key"></a> [secure\_storage\_master\_key](#input\_secure\_storage\_master\_key) | (Optional) The Secure Storage Master Key password<br><br>  Default: null | `string` | `null` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | (Optional) Additional tags for the security group<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_send_stats"></a> [send\_stats](#input\_send\_stats) | (Required) Whether to Opt-in to Sophos customer telemetry | `string` | n/a | yes |
| <a name="input_serial_number"></a> [serial\_number](#input\_serial\_number) | (Optional) The serial number of the firewall. Conflicts with PAYG SKU.<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_sfos_version"></a> [sfos\_version](#input\_sfos\_version) | (Optional) The firmware version to use for the deployed firewall<br><br>  Available versions are:<br>  18.0 MR3<br>  18.0 MR4<br>  18.0 MR5<br>  18.5 MR1<br>  18.5 MR2<br>  18.5 MR3<br>  19.0 MR1<br><br>  Default: "latest" | `string` | `"latest"` | no |
| <a name="input_sfos_versions"></a> [sfos\_versions](#input\_sfos\_versions) | (Optional) Version of SFOS firmware to use with the EC2 instance<br><br>    Default: "" | `map(any)` | <pre>{<br>  "18.0 MR3": "18.0.3.457",<br>  "18.0 MR4": "18.0.4.506",<br>  "18.0 MR5": "18.0.5.585",<br>  "18.5 MR1": "18.5.1.326",<br>  "18.5 MR2": "18.5.2.380",<br>  "18.5 MR3": "18.5.3.408",<br>  "latest": "19.0.0.317"<br>}</pre> | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The SKU to use for the AMI. Can be either payg or byol<br><br>  Default: payg | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | (Optional) The name of the SSH key to use to authenticate to the firewall.<br><br>  Default: null | `string` | `null` | no |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | (Optional) The subnet prefix. Conflicts with public\_subnet/private\_subnet.<br><br>  Default: "24" | `string` | `"24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources<br><br>    Default: {} | `map(string)` | `{}` | no |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | (Required) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.<br><br>    The default behavior is to include the public IP address from which the Terraform plan is run.<br><br>    EG: 192.168.10.24/32 | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | (Optional) The VPC ID to associate the subnet<br><br>  Default: null | `string` | `null` | no |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | (Optional) Additional tags to attach to the VPC<br><br>    Default: {} | `map(string)` | `{}` | no |

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
