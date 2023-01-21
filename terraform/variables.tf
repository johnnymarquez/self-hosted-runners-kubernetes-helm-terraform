variable "workspace_name" {
  type    = string
  default = ""
}

variable "aws" {
  type = object({
    tf_role_name = string,
    account_id   = string,
    region       = string,
  })
}

variable "s3" {
  type = map(object({
    logging = object({
      enabled       = bool,
      target_bucket = string,
      target_prefix = string,
    }),
    attach_deny_insecure_transport_policy = bool,
    attach_require_latest_tls_policy      = bool,
    versioning_enabled                    = bool,
    block_public_acls                     = bool,
    block_public_policy                   = bool,
    ignore_public_acls                    = bool,
    restrict_public_buckets               = bool,
    create_bucket                         = bool,
    acl                                   = string,
    object_ownership                      = string,
    control_object_ownership              = bool
    lifecycle_rule                        = map(object({
      enabled    = bool,
      expiration = object({
        days                         = number,
        expired_object_delete_marker = bool,
      }),
      noncurrent_version_expiration = object({
        days = number
      }),
    })),
  }))
}

variable "vpc" {
  type = object({
    create_vpc                            = bool
    cidr                                  = string
    azs                                   = list(string)
    private_subnets                       = list(string)
    public_subnets                        = list(string)
    create_elasticache_subnet_group       = bool
    create_elasticache_subnet_route_table = bool

    create_database_subnet_group           = bool
    create_database_subnet_route_table     = bool
    create_database_internet_gateway_route = bool
    enable_dns_hostnames                   = bool
    enable_dns_support                     = bool

    enable_nat_gateway     = bool
    single_nat_gateway     = bool
    one_nat_gateway_per_az = bool
    reuse_nat_ips          = bool

    enable_dhcp_options      = bool
    dhcp_options_domain_name = string
  })

  description = "Holds values for configuration of our VPC"
}

variable "eks" {
  type = object({
    create                               = bool
    create_nodegroup_external            = bool
    create_nodegroup_internal            = bool
    create_nodegroup_sys                 = bool
    cluster_version                      = string
    cluster_endpoint_public_access       = bool
    cluster_endpoint_private_access      = bool
    cluster_endpoint_public_access_cidrs = list(string)
  })
}

variable "ecr" {
  type = map(object({
    create_repository = bool,
  }))
}
