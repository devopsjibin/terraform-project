terraform {
  required_version = ">= 1.7.0"
  backend "s3" {
    bucket = "mygit-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

