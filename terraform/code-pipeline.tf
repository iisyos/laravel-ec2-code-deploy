module "code_deploy" {
  source = "./modules/code-deploy"

  app_name    = local.app_name
  instance_id = module.ec2.instance_id
}

module "s3-repository" {
  source = "./modules/s3-repository"

  app_name = local.app_name
}

module "code_build" {
  source = "./modules/code-build"

  app_name       = local.app_name
  s3_bucket_arn  = module.s3-repository.s3_bucket_arn
  s3_bucket_name = module.s3-repository.s3_bucket_name
}

module "code_pipeline" {
  source = "./modules/code-pipeline"

  app_name           = local.app_name
  source_repo_name   = local.source_repo_name
  source_repo_branch = local.source_repo_branch
  s3_bucket_arn      = module.s3-repository.s3_bucket_arn
  s3_bucket_name     = module.s3-repository.s3_bucket_name
  connection_arn     = local.connection_arn

  code_build_project_name           = module.code_build.code_build_project_name
  code_deploy_app_name              = module.code_deploy.code_deploy_app_name
  code_deploy_deployment_group_name = module.code_deploy.code_deploy_deployment_group_name
}

