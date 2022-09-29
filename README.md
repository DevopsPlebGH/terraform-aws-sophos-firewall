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
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.2.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.32.0 |
| <a name="provider_http"></a> [http](#provider\_http) | 3.1.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_instance_profile.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.lambda_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.register_in_central](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_lambda_function.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
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
| [archive_file.lambda_zip](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_ami.dynamic_ami](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_ami_ids.sfos](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami_ids) | data source |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.central](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ec2_iam_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_execution_inline_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_execution_trust_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.secure_storage_master_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.trust_relationship](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [http_http.my_public_ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autodetect"></a> [autodetect](#input\_autodetect) | (Optional) Whether or not to use the latest version of the AMI.<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_availability_zone"></a> [availability\_zone](#input\_availability\_zone) | (Required) The availability zone in which to deploy the firewall. | `string` | n/a | yes |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | (Required) The region in which to deploy the firewall | `string` | n/a | yes |
| <a name="input_central_password"></a> [central\_password](#input\_central\_password) | (Optional) The password for your Sophos Central account if you would like to register the firewall with Sophos Central<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_central_username"></a> [central\_username](#input\_central\_username) | (Optional) Sophos Central username if registering the firewall to Central<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_cicd_ip"></a> [cicd\_ip](#input\_cicd\_ip) | (Optional) Whether to include the IP address of the CI/CD runner in the Trusted Network security group. <br><br>  Default: true | `bool` | `true` | no |
| <a name="input_cidr_block"></a> [cidr\_block](#input\_cidr\_block) | (Optional) The CIDR range for the VPC CIDR block.<br><br>    Default: "10.0.0.0/16" | `string` | `"10.0.0.0/16"` | no |
| <a name="input_config_backup_password"></a> [config\_backup\_password](#input\_config\_backup\_password) | (Required) The password to secure the configuration backup. | `string` | n/a | yes |
| <a name="input_console_password"></a> [console\_password](#input\_console\_password) | (Required) The password for the firewall management console. | `string` | n/a | yes |
| <a name="input_create_elastic_ip"></a> [create\_elastic\_ip](#input\_create\_elastic\_ip) | (Optional) If set to false, an existing elastic IP allocation ID will need to be provided. | `bool` | `true` | no |
| <a name="input_create_s3_bucket"></a> [create\_s3\_bucket](#input\_create\_s3\_bucket) | (Optional) Whether or not an S3 bucket should be created for the firewall configuration backups.<br><br>  Default: false | `bool` | `false` | no |
| <a name="input_create_vpc"></a> [create\_vpc](#input\_create\_vpc) | (Optional) If set to false, an existing VPC ID and existing subnet ID's will need to be provided.<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_debug"></a> [debug](#input\_debug) | (Optional) Enable debugging in the module | `bool` | `true` | no |
| <a name="input_elastic_ip_tags"></a> [elastic\_ip\_tags](#input\_elastic\_ip\_tags) | (Optional) Additional tags to attach to the Elastic IP Address<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | (Optional) Controls whether or not DNS hostname support should be enabled in the VPC<br><br>    Default: true | `bool` | `true` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | (Optional) Controls whether DNS support should be enabled in the VPC<br><br>  Default: true | `bool` | `true` | no |
| <a name="input_eula"></a> [eula](#input\_eula) | (Required) Use of this software is subject to the Sophos End User License Agreement (EULA) at https://www.sophos.com/en-us/legal/sophos-end-user-license-agreement.aspx. | `string` | n/a | yes |
| <a name="input_firewall_hostname"></a> [firewall\_hostname](#input\_firewall\_hostname) | (Optional) The hostname of the firewall<br><br>  Default: "sophos-firewall-tf" | `string` | `"sophos-firewall-tf"` | no |
| <a name="input_iam_role_tags"></a> [iam\_role\_tags](#input\_iam\_role\_tags) | (Optional) Additional tags to attach to created IAM roles<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_profile_tags"></a> [instance\_profile\_tags](#input\_instance\_profile\_tags) | (Optional) Additional tags to attach to instance profile<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_size"></a> [instance\_size](#input\_instance\_size) | (Required) The size of the instance to deploy. Available instance sizes are:<br><br>    t3.small<br>    t3.medium <br>    m3.xlarge <br>    m3.2xlarge<br>    m4.large<br>    m4.xlarge <br>    m5.large<br>    m5.xlarge <br>    m5.2xlarge<br>    c3.xlarge <br>    c3.2xlarge<br>    c3.4xlarge<br>    c3.8xlarge<br>    c4.large<br>    c4.xlarge <br>    c4.2xlarge<br>    c4.4xlarge<br>    c4.8xlarge<br>    c5.large<br>    c5.xlarge <br>    c5.2xlarge<br><br>  Default: "m5.large" | `string` | n/a | yes |
| <a name="input_instance_tags"></a> [instance\_tags](#input\_instance\_tags) | (Optional) Additional tags to attach to the EC2 instance<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | (Optional) The EC2 instance type to use for the firewall | `map(any)` | <pre>{<br>  "c3.2xlarge": "c3.2xlarge",<br>  "c3.4xlarge": "c3.4xlarge",<br>  "c3.8xlarge": "c3.8xlarge",<br>  "c3.xlarge": "c3.xlarge",<br>  "c4.2xlarge": "c4.2xlarge",<br>  "c4.4xlarge": "c4.4xlarge",<br>  "c4.8xlarge": "c4.8xlarge",<br>  "c4.large": "c4.large",<br>  "c4.xlarge": "c4.xlarge",<br>  "c5.2xlarge": "c5.2xlarge",<br>  "c5.large": "c5.large",<br>  "c5.xlarge": "c5.xlarge",<br>  "m3.2xlarge": "m3.2xlarge",<br>  "m3.xlarge": "m3.xlarge",<br>  "m4.large": "m4.large",<br>  "m4.xlarge": "m4.xlarge",<br>  "m5.2xlarge": "m5.2xlarge",<br>  "m5.large": "m5.large",<br>  "m5.xlarge": "m5.xlarge",<br>  "t3.medium": "t3.medium",<br>  "t3.small": "t3.small"<br>}</pre> | no |
| <a name="input_internet_gateway_tags"></a> [internet\_gateway\_tags](#input\_internet\_gateway\_tags) | (Optional) Additional tags to attach to created internet gateways<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_launch_template_tags"></a> [launch\_template\_tags](#input\_launch\_template\_tags) | (Optional) Additional tags to attach to the launch template<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | (Internal) Namespace refers to the application or deployment type.<br><br>    EG: SOPHOS\_CNF, SOPHOS\_CNS, SOPHOS\_CWP, etc...<br><br>    Default: SOPHOS | `string` | `"SOPHOS_CNF"` | no |
| <a name="input_private_eni_tags"></a> [private\_eni\_tags](#input\_private\_eni\_tags) | (Optional) Additional tags to attach to the private ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_route_table_tags"></a> [private\_route\_table\_tags](#input\_private\_route\_table\_tags) | (Optional) Additional tags to attach to the public route table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_private_subnet"></a> [private\_subnet](#input\_private\_subnet) | (Optional) The CIDR block of the private subnet. Conflicts with subnet\_prefix<br><br>  Default: null | `string` | `null` | no |
| <a name="input_public_eni_tags"></a> [public\_eni\_tags](#input\_public\_eni\_tags) | (Optional) Additional tags to attach to the public ENI<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_route_table_tags"></a> [public\_route\_table\_tags](#input\_public\_route\_table\_tags) | (Optional) Additional tags to attach to the Public Route Table<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_public_subnet"></a> [public\_subnet](#input\_public\_subnet) | (Optional) The CIDR block of the public subnet. Conflicts with subnet\_prefix.<br><br>  Default: null | `string` | `null` | no |
| <a name="input_public_subnet_tags"></a> [public\_subnet\_tags](#input\_public\_subnet\_tags) | (Optional) Additional tags for the public subnets.<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_s3bucket"></a> [s3bucket](#input\_s3bucket) | (Optional) An S3 bucket in which to store configuration backups. If used in conjunction with "create\_s3\_bucket", this module will create the S3 bucket.<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_secure_storage_master_key"></a> [secure\_storage\_master\_key](#input\_secure\_storage\_master\_key) | (Optional) The Secure Storage Master Key password<br><br>  Default: "" | `string` | `true` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | (Optional) Additional tags to attach to security groups<br><br>  Default: {} | `map(string)` | `{}` | no |
| <a name="input_send_stats"></a> [send\_stats](#input\_send\_stats) | (Required) Whether to Opt-in to Sophos customer telemetry | `string` | n/a | yes |
| <a name="input_serial_number"></a> [serial\_number](#input\_serial\_number) | (Optional) The serial number of the firewall. Conflicts with PAYG SKU.<br><br>  Default: "" | `string` | `""` | no |
| <a name="input_sfos_version"></a> [sfos\_version](#input\_sfos\_version) | (Optional) The firmware version to use for the deployed firewall<br><br>  Available versions are:<br>   18.0 MR3<br>   18.0 MR4<br>   18.0 MR5<br>   18.5 MR1<br>   18.5 MR2<br>   18.5 MR3<br>   19.0 MR1<br><br>  Default: "latest" | `string` | `"latest"` | no |
| <a name="input_sfos_versions"></a> [sfos\_versions](#input\_sfos\_versions) | (Optional) Version of SFOS firmware to use with the EC2 instance<br><br>    Default: "" | `map(any)` | <pre>{<br>  "18.0 MR3": "18.0.3.457",<br>  "18.0 MR4": "18.0.4.506",<br>  "18.0 MR5": "18.0.5.585",<br>  "18.5 MR1": "18.5.1.326",<br>  "18.5 MR2": "18.5.2.380",<br>  "18.5 MR3": "18.5.3.408",<br>  "latest": "19.0.0.317"<br>}</pre> | no |
| <a name="input_sku"></a> [sku](#input\_sku) | (Required) The SKU to use for the AMI. Can be either payg or byol<br><br>  Default: payg | `string` | n/a | yes |
| <a name="input_ssh_key_name"></a> [ssh\_key\_name](#input\_ssh\_key\_name) | (Required) The name of the SSH key to use to authenticate to the firewall. | `string` | n/a | yes |
| <a name="input_subnet_prefix"></a> [subnet\_prefix](#input\_subnet\_prefix) | (Optional) The subnet prefix. Conflicts with public\_subnet/private\_subnet.<br><br>  Default: "24" | `string` | `"24"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A map of tags to add to all resources<br><br>    Default: {} | `map(string)` | `{}` | no |
| <a name="input_trusted_ip"></a> [trusted\_ip](#input\_trusted\_ip) | (Required) A trusted IP in CIDR format that will be added to the Trusted Network security group to allow access to the firewall console.<br><br>    The default behavior is to include the public IP address from which the Terraform plan is run.<br><br>    EG: 192.168.10.24/32 | `list(string)` | n/a | yes |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | (Optional) Additional tags to attach to the VPC<br><br>    Default: {} | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | n/a |
| <a name="output_ami_map"></a> [ami\_map](#output\_ami\_map) | The map of AMI's available. |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zone that the resources were deployed in if no availability zone was specified. |
| <a name="output_firewall_ip_address"></a> [firewall\_ip\_address](#output\_firewall\_ip\_address) | The public IP for the firewall |
| <a name="output_firewall_public_dns_name"></a> [firewall\_public\_dns\_name](#output\_firewall\_public\_dns\_name) | The public DNS name for the firewall. |
| <a name="output_lambda_archive"></a> [lambda\_archive](#output\_lambda\_archive) | n/a |
| <a name="output_template_file"></a> [template\_file](#output\_template\_file) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
