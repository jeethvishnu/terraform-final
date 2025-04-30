resource "aws_instance" "expense" {
    ami = "ami-09c813fb71547fc4f"
    vpc_security_group_ids = ["sg-07fad016c7fd8f34f"]
    instance_type = "t2.micro"

    #provisioners will only run when you create a resource
    # they will not run once the resource is created.
    #two types local and remote exec.
  provisioner "local-exec" {
    command = "echo ${self.private_ip} > private_ips.txt" #self is aws_instance.web
  }

    #we are writing h this because if we create any server in that if any configurations needed it will do.
#   provisioner "local-exec" {
#     command = "ansible-playbook -i private_ips.txt web.yaml" #self is aws_instance.web
#   }

  connection {
    type     = "ssh"
    user     = "ec2-user"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install ansible -y",
      "sudo dnf install nginx -y",
      "sudo systemctl start nginx"
    ]
  }

}
