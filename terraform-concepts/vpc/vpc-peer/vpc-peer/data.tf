data "aws_availability_zones" "available" {

}

#we will get this module from online as aws vpc default
data "aws_vpc" "default" {
    default = true
  
}

#this one for default vpc route we can get in online
data "aws_route_table" "main" {
    vpc_id = data.aws_vpc.default.id
    filter {
      name = assocation.main
      values = ["true"]
    }
  
}
