provider "aws" {
  region     = var.aws_region
  default_tags {
    tags = {
      project = var.projectname
      env     = var.project_env
      email   = var.emailid
    }
  }

}

