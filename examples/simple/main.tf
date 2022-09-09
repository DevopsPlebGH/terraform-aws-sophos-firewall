#module "key-pair" {
#  source             = "terraform-aws-modules/key-pair/aws"
#  version            = "2.0.0"
#  key_name           = "sophos"
#  create_private_key = true
#}

module "example-basic" {
  source                    = "../../"
  create_vpc                = true
}

