terraform {
    required_providers {
        aws= {
            source = "hashicorp/aws"
            version = "5.21.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "imersao-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true

tags = {
    "kubernetes.io/cluster/imersao-eks" = "shared"
    #Terraform = "true"
    #Environment = "dev"
}

public_subnet_tags = {
    "kubernetes.io/cluster/imersao-eks" = "shared"
    "kubernetes.io/role/elb" = 1
}

private_subnet_tags = {
    "kubernetes.io/cluster/imersao-eks" = "shared"
    "kubernetes.io/role/internal-elb" = 1
}

}
