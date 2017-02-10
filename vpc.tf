module "vpc" {
  source = "terraform/modules/vpc"

  name = "test-vpc"

  cidr = "10.5.0.0/16"
  private_subnets = ["10.5.1.0/24", "10.5.2.0/24", "10.5.3.0/24"]
  public_subnets  = ["10.5.101.0/24", "10.5.102.0/24", "10.5.103.0/24"]

  enable_nat_gateway = "true"

  azs      = ["us-west-2a", "us-west-2b"]

  tags {
    "Terraform" = "true"
    "Environment" = "Dev"
    "Owner" = "mike.mcclintock@sonos.com"
  }
}
