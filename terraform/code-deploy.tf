module "code_deploy" {
  source = "./modules/code-deploy"

  app_name    = local.app_name
  instance_id = module.ec2.instance_id
}
