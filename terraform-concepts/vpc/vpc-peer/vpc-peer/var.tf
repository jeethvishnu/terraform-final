variable "is_peering_yes" {
  type = bool
  default = false
}

#reciever vpc

variable "acceptor_vpc" {
    type = string
    default = {}
  
}

variable "is_peering_yes" {
    type = string
    default = ""
  
}

variable "is_peering_tags" {
    type = map
    default = {}

}

variable "common_tags" {
  type = map
  
}

variable "cidr" {
    type = string
    default = "10.0.0.0/16"
  
}