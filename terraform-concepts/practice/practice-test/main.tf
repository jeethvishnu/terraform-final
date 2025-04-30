module "vpc" {
    source = "../vpc-1"
    project_name = var.project_name
    common_tags = var.common_tags
    nat_tags = var.nat_tags
    pub_cidr = var.pub_cidr
    private_cidr = var.private_cidr
  
}