terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }

    local = {
      source  = "hashicorp/local"
      version = "~> 2.1"
    }
  }
}

provider "aws" {
  region            = "us-east-1"
  access_key        = "test" # localstack accetta valori fittizi
  secret_key        = "test"
  s3_use_path_style = true # fondamentale per far funzionare s3 con localstack

  # salta la verifica delle credenziali

  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  skip_region_validation      = true


  endpoints {
    s3  = "http://localhost:4566"
    ec2 = "http://localhost:4566"
    sts = "http://localhost:4566"
    iam = "http://localhost:4566"
  }
}
