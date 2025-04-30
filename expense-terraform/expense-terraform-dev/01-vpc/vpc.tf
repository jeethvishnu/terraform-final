module "vpc" {
    #source = "../aws-vpc"
    source = "git::https://github.com/jeethvishnu/terraform.git//vpc/aws-vpc?ref=main" #our repo url by default it will take main branch.... this is used to take the terraform code from remote not local.
    project_name = var.project
    common_tags = var.common_tags
    public_cidrs = var.public_subnet_cidrs
    private_cidrs = var.private_cidrs
    database_cidrs = var.database_cidrs
    
  
}

