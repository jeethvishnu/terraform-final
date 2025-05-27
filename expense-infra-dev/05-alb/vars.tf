variable "project" {
    type = string
    default = "expense"
  
}

variable "env" {
    type = string
    default = "dev"
  
}



variable "common_tags" {
    default = {
        Project = "expense"
        Env = "dev"
        Terraform = "true"
        Component = "alb"
    }
}

variable "zone_name" {
    default = "vjeeth.site"
  
}