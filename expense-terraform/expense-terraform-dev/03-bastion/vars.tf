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
