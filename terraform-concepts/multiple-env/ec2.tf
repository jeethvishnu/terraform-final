resource "aws_instance" "expense" {
    for_each = var.instance_names  # each.key and each.value
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = ["sg-07fad016c7fd8f34f"]
    instance_type = each.value


    tags = merge(
        var.common_tags,
        {
            Name = "${each.key}"
            Module = "${each.key}"
            envi = var.env
        }
    )
}

