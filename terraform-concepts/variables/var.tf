variable "image_id" {
    type = string
    default = "ami-09c813fb71547fc4f"
    description = "RHEL -9 ami id" #optional

}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "tags" {
    default = {
        Project = "expense"
        Env = "dev"
        Module = "db"
        Name = "db"
    }
}

variable "sg" {
    default = "allow-all"
}

variable "desc" {
    default = "allowing ssh"

}

variable "fp" {
    default = 22
}

variable "tp" {
    default = 22
}

variable "type_call" {
    default = "tcp"
}

variable "allow_cidr" {
    type = list(string) 
    default = ["0.0.0.0/0"]
}


