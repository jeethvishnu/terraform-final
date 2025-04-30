output "ami_id" {
    value = data.aws_ami.ami_id.id
}

output "default_vpc" {
    value = data.aws_vpc.vpc_info_default
}
