module "ec2-test" {
    source = "../module-dev"
    type = "t3.small" #whatever we want to overrite we can givee here
    tags = {
        Name = "module-test"
        terraform = "true"
    }

}



