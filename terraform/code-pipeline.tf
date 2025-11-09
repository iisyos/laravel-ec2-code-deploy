module "code_deploy" {
  source = "./modules/code-deploy"

  app_name    = local.app_name
  instance_id = module.ec2.instance_id
}

module "s3-repository" {
  source = "./modules/s3-repository"

  app_name = local.app_name
}
