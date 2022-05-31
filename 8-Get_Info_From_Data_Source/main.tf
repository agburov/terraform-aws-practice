provider "aws" {}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
data "aws_vpcs" "available" {}

output "info_aws_region_name" {
  value = data.aws_region.current.name
}

output "info_aws_region_description" {
  value = data.aws_region.current.description
}

output "info_aws_availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "info_aws_availability_3rd_zone" {
  value = data.aws_availability_zones.available.names[2]
}

output "info_aws_caller_identity_id" {
  value = data.aws_caller_identity.current.account_id
}

output "info_aws_vpcs_ids" {
  value = data.aws_vpcs.available.ids
}
