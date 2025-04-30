### project vars###
variable "project_name" {
    type = string
    
  
}

variable "environment" {
    type = string
    default = "dev"
  
}

variable "common_tags" {
    type = map
  
}


#vpc vars

variable "cidr" {
    type = string
    default = "10.0.0.0/16"
  
}

variable "enable_dns_hostnames" {
    type = bool
    default = true
  
}

#optional
variable "vpc_tags" {
  type = map
  default = {}

}

#igw tags

variable "igw_tags" {
    type = map
    default = {}
  
}

#public subnet
variable "public_cidrs" {
    type = list
      validation {
        condition = length(var.public_cidrs) == 2
        error_message = "please provide 2 valid public cidrs"
      }
  
}

variable "public_cidrs_tags" {
    type = map
    default = {}
  
}

#private subnets

variable "private_cidrs" {
    type = list
      validation {
        condition = length(var.private_cidrs) == 2
        error_message = "please provide 2 valid private cidrs"
      }
  
}

variable "private_cidrs_tags" {
    type = map
    default = {}
  
}

#database subnet

variable "database_cidrs" {
    type = list
      validation {
        condition = length(var.database_cidrs) == 2
        error_message = "please provide 2 valid database cidrs"
      }
  
}

variable "database_cidrs_tags" {
    type = map
    default = {}
  
}

#nat

variable "nat_tags" {
  type = map
  default = {}
  
}

#route table vars

variable "public_rtable_tags" {
    type = map
    default = {}
  
}

variable "private_rtable_tags" {
    type = map
    default = {}
  
}

variable "database_rtable_tags" {
    type = map
    default = {}
  
}

#vpc peering vars

# variable "is_peering_yes" {
#   type = bool
#   default = false
# }

# #reciever vpc

# variable "acceptor_vpc" {
#     type = string
#     default = {}
  
# }

# variable "is_peering_yes" {
#     type = string
#     default = ""
  
# }

# variable "is_peering_tags" {
#     type = map
#     default = {}
  
# }

variable "database_subnet_grp_tags" {
    type = map
    default = {}
  
}