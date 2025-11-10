data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.app_name}-codepipeline-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:GetBucketVersioning",
      "s3:PutObjectAcl",
      "s3:PutObject",
    ]

    resources = [
      var.s3_bucket_arn,
      "${var.s3_bucket_arn}/*"
    ]
  }

  statement {
    effect    = "Allow"
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.connection_arn]
  }

  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  # Allow CodePipeline to interact with CodeDeploy applications and deployment groups
  statement {
    effect = "Allow"

    actions = [
      "codedeploy:CreateDeployment",
      "codedeploy:GetApplication",
      "codedeploy:GetDeployment",
      "codedeploy:RegisterApplicationRevision",
      "codedeploy:ListDeployments",
      "codedeploy:ListDeploymentGroups",
      "codedeploy:GetDeploymentGroup",
    ]

    resources = [
      "arn:aws:codedeploy:*:${data.aws_caller_identity.current.account_id}:application:${var.code_deploy_app_name}",
      "arn:aws:codedeploy:*:${data.aws_caller_identity.current.account_id}:deploymentgroup:${var.code_deploy_app_name}/${var.code_deploy_deployment_group_name}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codedeploy:GetDeploymentConfig",
    ]

    resources = [
      "arn:aws:codedeploy:*:*:deploymentconfig:CodeDeployDefault.*"
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "codedeploy:ListDeploymentConfigs",
    ]

    resources = ["*"]
  }

}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "${var.app_name}-codepipeline-policy"
  role   = aws_iam_role.codepipeline_role.id
  policy = data.aws_iam_policy_document.codepipeline_policy.json
}

resource "aws_codepipeline" "terraform_pipeline" {

  name     = "${var.app_name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = var.s3_bucket_name
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      run_order        = 1

      configuration = {
        ConnectionArn    = var.connection_arn
        FullRepositoryId = "iisyos/laravel-ec2-code-deploy"
        BranchName       = "main"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"
      run_order        = 2

      configuration = {
        ProjectName = var.code_build_project_name
      }
    }
  }

  # https://docs.aws.amazon.com/codepipeline/latest/userguide/action-reference-CodeDeploy.html
  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "CodeDeploy"
      input_artifacts = ["build_output"]
      version         = "1"
      run_order       = 3

      configuration = {
        ApplicationName     = var.code_deploy_app_name
        DeploymentGroupName = var.code_deploy_deployment_group_name
      }
    }
  }
}
