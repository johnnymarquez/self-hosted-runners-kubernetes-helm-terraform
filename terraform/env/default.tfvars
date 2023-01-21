aws = {
  account_id   = ""
  region       = "eu-west-1"
  tf_role_name = ""
}

s3 = {
  "infrastructure-as-code" = {
    create_bucket                         = true
    acl                                   = null
    versioning_enabled                    = false
    block_public_acls                     = true
    block_public_policy                   = true
    ignore_public_acls                    = true
    restrict_public_buckets               = true
    control_object_ownership              = true
    object_ownership                      = "BucketOwnerEnforced"
    attach_deny_insecure_transport_policy = true
    attach_require_latest_tls_policy      = true
    logging                               = {
      enabled       = false
      target_bucket = "" # dynamcally generated in s3 code
      target_prefix = "" # dynamcally generated in s3 code
    }
    lifecycle_rule = {
      "delete-terraform-plan-after-5d" = {
        enabled    = true
        expiration = {
          days                         = 5
          expired_object_delete_marker = false
        }
        noncurrent_version_expiration = {
          days = 5
        }
      }
    }
  }

  "logs" = {
    create_bucket                         = true
    acl                                   = null
    versioning_enabled                    = false
    block_public_acls                     = true
    block_public_policy                   = true
    ignore_public_acls                    = true
    restrict_public_buckets               = true
    control_object_ownership              = false
    object_ownership                      = "BucketOwnerEnforced"
    attach_deny_insecure_transport_policy = true
    attach_require_latest_tls_policy      = true
    logging                               = {
      enabled       = false
      target_bucket = "" # dynamcally generated in s3 code
      target_prefix = "" # dynamcally generated in s3 code
    }
    lifecycle_rule = {
      "delete-s3-after-5d" = {
        enabled    = true
        expiration = {
          days                         = 5
          expired_object_delete_marker = false
        }
        noncurrent_version_expiration = {
          days = 5
        }
      },
      "delete-vpc-after-3d" = {
        enabled    = true
        expiration = {
          days                         = 3
          expired_object_delete_marker = false
        }
        noncurrent_version_expiration = {
          days = 5
        }
      }
    }
  }
}

vpc = {
  create_vpc                             = true
  azs                                    = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  cidr                                   = "10.50.0.0/16"
  create_database_internet_gateway_route = false #! no public access for prod database
  create_database_subnet_group           = false
  create_database_subnet_route_table     = false
  dhcp_options_domain_name               = ""
  enable_dhcp_options                    = true
  enable_dns_hostnames                   = true
  enable_dns_support                     = true
  enable_nat_gateway                     = true
  one_nat_gateway_per_az                 = true
  public_subnets                         = ["10.50.0.0/19", "10.50.32.0/19", "10.50.64.0/19"]
  private_subnets                        = ["10.50.96.0/19", "10.50.128.0/19", "10.50.160.0/19"]
  create_elasticache_subnet_group        = false
  create_elasticache_subnet_route_table  = false
  reuse_nat_ips                          = true
  single_nat_gateway                     = false
}

eks = {
  create                               = true
  create_nodegroup_external            = false
  create_nodegroup_internal            = false
  create_nodegroup_sys                 = true
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  cluster_version                      = "1.24"
}

ecr = {
  "first_registry" = {
    create_repository = true
  }
}
