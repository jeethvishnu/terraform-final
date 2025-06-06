terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  backend "s3" {
    bucket = "vjeeth-dev1"
    key    = "expense-dev-backend"
    region = "us-east-1"
    dynamodb_table = "terraform-lock"  # we will use for s3 locking file this table should be there
  }
}



#provide authentication here

provider "aws" {
  region = "us-east-1"
}

