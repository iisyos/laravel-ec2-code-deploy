# Laravel EC2 CI/CD with AWS Code Series

## Overview

Experimental implementation of a CI/CD pipeline for Laravel using AWS CodePipeline, CodeBuild, and CodeDeploy.

## Architecture

```
GitHub Push → CodePipeline → CodeBuild → CodeDeploy → EC2
```

## Features

- **Automated deployments** on push to `main` branch
- **Path-based triggers** for `laravel/**` changes only
- **Zero-downtime deployment** using symlinks
- **Infrastructure as Code** with Terraform

## Project Structure

```
.
├── laravel/               # Laravel application
│   ├── appspec.yml       # CodeDeploy config
│   ├── buildspec.yml     # CodeBuild config
│   └── deploy-scripts/   # Deployment scripts
└── terraform/            # Infrastructure definitions
```

## Setup

1. Create GitHub connection

```bash
aws codestar-connections create-connection --provider-type GitHub --connection-name laravel
```

2. Deploy infrastructure

```bash
cd terraform
terraform init && terraform apply
```

3. Push code

```bash
git push origin main
```

## Configuration

- Build: Edit `laravel/buildspec.yml`
- Deploy: Edit `laravel/appspec.yml`
- Infrastructure: Modify `terraform/` files
