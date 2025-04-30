variable "cidrs" {
    default = "10.0.0.0/16"
  
}

variable "dns_hostname" {
    type = bool
    default = true
  
}

variable "vpc_tags" {
    type = map
    default = {}
  
}

variable "project_name" {
    type = string
  
}

variable "env" {
    type = string
    default = "dev"
  
}

variable "common_tags" {
    type = map
  
}

variable "igw_tags" {
    type = map
    default = {}
}

variable "pub_cidr" {
    type = string
    # default = {}
  
}

variable "pub_sub_tags" {
    type = map
    default = {}
  
}

variable "private_cidr" {
    type = string
    # default = {}
  
}

variable "private_sub_tags" {
    type = map
    default = {}
  
}

variable "nat_tags" {
    type = map
}


variable "pub_rtable_tags" {
    type = map
    default = {}
  
}

variable "private_rtable_tags" {
    type = map
    default = {}
  
}

