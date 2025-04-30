variable "project_name" {
    type = string
    default = "Mine"
  
}

variable "common_tags" {
    default = {
        project = "Mine"
        env = "dev"
        Terraform = "true"
    }
  
}

variable "nat_tags" {
    default = {}
  
}

variable "pub_cidr" {
    default = "10.0.1.0/24"
  
}

variable "private_cidr" {
    default = "10.0.11.0/24"
  
}

