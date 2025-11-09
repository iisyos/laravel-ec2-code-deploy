module "vpc" {
  source  = "kasaikou/vpc/aws"
  version = "v0.1.1"

  name       = "my-vpc"
  cidr_block = "10.0.0.0/16"

  subnets = {
    "public-primary" = {
      availability_zone = "ap-northeast-1a"
      cidr_block        = "10.0.1.0/24"
      route_tables      = ["igw"]
    }
  }
}
