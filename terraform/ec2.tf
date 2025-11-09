data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "ec2" {
  source = "./modules/ec2"

  app_name      = local.app_name
  ami_id        = data.aws_ami.amazon_linux_2023.id
  instance_type = "t3.small"
  subnet_id     = module.vpc.subnet_ids["public-primary"]
  vpc_id        = module.vpc.vpc_id

  instance_state = "running"
}


output "ec2_public_dns" {
  value = module.ec2.public_dns
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
