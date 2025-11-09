module "code_build" {
  source = "./modules/code-build"

  app_name    = local.app_name
  instance_id = module.ec2.instance_id
}
