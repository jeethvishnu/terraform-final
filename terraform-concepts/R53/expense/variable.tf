#ec2 variables


variable "instance_names" {
    type = list
    default = ["db","backend","frontend"]
}

variable "image_id" {
    default = "ami-09c813fb71547fc4f"
}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "common_tags" {
    default = {
        Project = "expense"
        Env = "db"
        Terraform = "true"
    }
}

#security grps variables

variable "grp_name" {
    default = "all-allow"
}

variable "grp_desp" {
    default = "allowing ssh"
}

#ports variables

variable "fp" {
    default = 22
}

variable "tp" {
    default = 22
}

variable "type_call" {
    default = "tcp"
}

variable "cidr" {
    type = list(string)
    default = ["0.0.0.0/0"]
}

#R53 variables

variable "zone_id" {
    default = "Z0724324Z6IHS7J6W01"
}

variable "domain_name" {
    default = "vjeeth.site"
}
