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

variable "vpn_sg_rules" {
    default = [
        {
            
                from_port = 943
                to_port = 943
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            
        },
        {
            
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        },
        {
            
                from_port = 22
                to_port = 22
                protocol = "tcp" #all
                cidr_blocks = ["0.0.0.0/0"]
        },
         {
            
                from_port = 1194
                to_port = 1194
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }      
    ]
  
}