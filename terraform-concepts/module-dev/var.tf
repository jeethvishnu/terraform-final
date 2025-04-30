variable "ami" {
    type = string
    default = "ami-09c813fb71547fc4f"
  
}

variable "sgrp" {
    type = list(string)
    default = [ "sg-07fad016c7fd8f34f" ]
  
}
variable "type" {
    type = string
    default = "t2.micro"
  
}

variable "tags" {
    type = map
    default = {} #this means empty not mandatory
  
}

