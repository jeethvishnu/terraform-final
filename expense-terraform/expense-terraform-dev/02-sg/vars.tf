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

    }
  
}

variable "db_sg_descr" {
    default = "SG for db mysql instnace"
  
}
variable "sg_tags" {
  type = map
  default = {}
}