variable "app_name" {
  description = "The name of the application for which CodePipeline needs to be configured"
  type        = string
}

variable "source_repo_name" {
  description = "Source repo name of the CodeCommit repository"
  type        = string
}

variable "source_repo_branch" {
  description = "Default branch in the Source repo for which CodePipeline needs to be configured"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name to be used for storing the artifacts"
  type        = string
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket to store artifacts"
  type        = string
}

variable "connection_arn" {
  description = "The ARN of the CodeStar connection to use for the source action"
  type        = string
}

variable "code_build_project_name" {
  description = "The name of the CodeBuild project to be used in the build stage"
  type        = string
}

variable "code_deploy_app_name" {
  description = "The name of the CodeDeploy application to be used in the deploy stage"
  type        = string
}

variable "code_deploy_deployment_group_name" {
  description = "The name of the CodeDeploy deployment group to be used in the deploy stage"
  type        = string
}
