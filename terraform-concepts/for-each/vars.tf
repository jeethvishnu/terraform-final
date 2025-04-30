variable "instance_names" {
    type = map
    default = {
        db = "t3.small"
        backend = "t2.micro"
        frontend = "t2.micro"
    }
}


variable "domain_name" {
    default = "vjeeth.site"
}

variable "zone_id" {
    default = "Z0724324Z6IHS7J6W01"
}


