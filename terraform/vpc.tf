resource "aws_eip" "nat" {
  count = 3

  vpc = true
}

module "vpc" {
  source     = "./vendor/modules/terraform-aws-vpc"
  create_vpc = var.vpc.create_vpc

  name = local.environment_id

  cidr = var.vpc.cidr

  azs             = var.vpc.azs
  private_subnets = var.vpc.private_subnets
  public_subnets  = var.vpc.public_subnets

  create_elasticache_subnet_group       = var.vpc.create_elasticache_subnet_group
  create_elasticache_subnet_route_table = var.vpc.create_elasticache_subnet_route_table

  # Allowing public access in test/dev environments
  create_database_subnet_group           = var.vpc.create_database_subnet_group
  create_database_subnet_route_table     = var.vpc.create_database_subnet_route_table
  create_database_internet_gateway_route = var.vpc.create_database_internet_gateway_route

  enable_dns_hostnames = var.vpc.enable_dns_hostnames
  enable_dns_support   = var.vpc.enable_dns_support

  enable_nat_gateway     = var.vpc.enable_nat_gateway
  single_nat_gateway     = var.vpc.single_nat_gateway
  one_nat_gateway_per_az = var.vpc.one_nat_gateway_per_az

  reuse_nat_ips       = var.vpc.reuse_nat_ips
  external_nat_ip_ids = aws_eip.nat.*.id

  enable_dhcp_options      = var.vpc.enable_dhcp_options
  dhcp_options_domain_name = join(".", [var.brand, "local"])

  private_subnet_tags = {
    # Karpenter needs these to provision new nodes
    "karpenter.sh/discovery/${local.environment_id}" = local.environment_id
  }
}
