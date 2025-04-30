variable "image_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = "RHEL -9 ami id" #optional

}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "instance_name" {
    default = "db"
}


