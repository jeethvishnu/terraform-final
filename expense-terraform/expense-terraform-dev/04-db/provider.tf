terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
  backend "s3" {
    bucket = "vjeeth-dev"
    key    = "expense-dev-db-rds"
    region = "us-east-1"
    dynamodb_table = "dev-table"  # we will use for s3 locking file this table should be there
  }
}



#provide authentication here

provider "aws" {
  region = "us-east-1"
}

