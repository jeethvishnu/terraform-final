module "vpc" {
    #source = "../aws-vpc"
    source = "git::https://github.com/jeethvishnu/terraform-final.git//terraform-concepts/vpc/aws-vpc?ref=main"
    project_name = var.project
    common_tags = var.common_tags
    public_cidrs = var.public_subnet_cidrs
    private_cidrs = var.private_cidrs
    database_cidrs = var.database_cidrs
    
  
}

