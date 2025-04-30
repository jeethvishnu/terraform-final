variable "instance_names" {
    type = map
    # default = {
    #     db-dev = "t3.small"
    #     backend-dev = "t2.micro"
    #     frontend-dev = "t2.micro"
    # }
}

variable "env" {
    # default = "dev"
  
}

variable "common_tags" {
  type = map
  default = {
    Project = "expense"
    Terraform = "true"
  }
}


variable "domain_name" {
    default = "vjeeth.site"
}

variable "zone_id" {
    default = "Z0724324Z6IHS7J6W01"
}


