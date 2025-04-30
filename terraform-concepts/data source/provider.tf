terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.87.0"
    }
  }
}

#provide authenticatin here

provider "aws" {
  region = "us-east-1"
}
