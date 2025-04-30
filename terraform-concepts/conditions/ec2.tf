resource "aws_instance" "db" {
    ami = var.image_id
    vpc_security_group_ids = [aws_security_group.allow-all.id]
    instance_type = var.instance_name == "db" ? "t3.small" : "t3.micro"

}
