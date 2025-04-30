module "vpc" {
    #source = "../aws-vpc"
    source = "git::https://github.com/jeethvishnu/terraform.git"
    project_name = var.project
    common_tags = var.common_tags
    public_cidrs = var.public_subnet_cidrs
    private_cidrs = var.private_cidrs
    database_cidrs = var.database_cidrs
    is_peering_yes = var.is_peering_yes
  
}

