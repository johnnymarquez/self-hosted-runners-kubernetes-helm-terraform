terraform {

  backend "remote" {
    organization = ""

    workspaces {
      name = "tooling"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.45"
    }
  }

  required_version = "1.3.2"
}
