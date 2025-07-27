module "backend" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  name = "${var.project}-${var.env}-backend"

  instance_type          = "t3.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]
  #convert string lst to lst and get first element
  subnet_id              = local.private_subnet_id
  ami    = data.aws_ami.ami_info.id
  

  tags = merge(
    var.common_tags,
    {
      Name: "${var.project}-${var.env}-vpn"
    }
  )
}

#null resource will not create any infra but this is useful to run local exec,remote exec and some file provisioners.

resource "null_resource" "backend" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
   instance_id = module.backend.id #this  willbe triggered everytime when instance is created
  }

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = module.backend.private_ip
      }

      provisioner "file" {   # tihis is used to copy the files from  local to remote
        source = "backend.sh"
        destination = "/tmp/backend.sh"

        
      }

      provisioner "remote-exec" { #this is for, after copying files for running the script we use
        inline = [ 
            "chmod +x /tmp/backend.sh",
            "sudo sh /tmp/backend.sh"
         ]
        
      }
}

#stop the servre

resource "aws_ec2_instance_state" "backend" {
  instance_id = module.backend.id
  state       = "stopped"

  #when it is gonna stop. stop it whne null provisioning ins completed  
  depends_on = [ null_resource.backend ]
}

#take ami

resource "aws_ami_from_instance" "backend" {
  name               = "${var.project}-${var.env}-${var.common_tags.Component}"
  source_instance_id = module.backend.id
  depends_on = [ aws_ec2_instance_state.backend ]
}

#delete ec2

resource "null_resource" "backend_delete" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
   instance_id = module.backend.id #this  willbe triggered everytime when instance is created
  }

    connection {
        type = "ssh"
        user = "ec2-user"
        password = "DevOps321"
        host = module.backend.private_ip
      }

      provisioner "local-exec" {
        command = "aws ec2 terminate-instances --instance-ids ${module.backend.id}"
        
      }
      depends_on = [ aws_ami_from_instance.backend ]

     
        
      }

#target grp

resource "aws_lb_target_group" "backend" {
  name     = "${var.project}-${var.env}-${var.common_tags.Component}"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = data.aws_ssm_parameter.vpc_id.value
  health_check {  
  path = "/health"
  port = 8080
  protocol = "HTTP"
  healthy_threshold = 2
  unhealthy_threshold = 2
  matcher = "200"
  }
}

#launch template

resource "aws_launch_template" "backend" {
  name = "${var.project}-${var.env}-${var.common_tags.Component}"


  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }


  image_id = aws_ami_from_instance.backend.id

  instance_initiated_shutdown_behavior = "terminate"


  instance_type = "t3.micro"
  update_default_version = true #sets the latest version to default


  vpc_security_group_ids = [data.aws_ssm_parameter.backend_sg_id.value]

  tag_specifications {
    resource_type = "instance"
  }

    tags = merge(
      var.common_tags,
      {
        Name = "${var.project}-${var.env}-${var.common_tags.Component}"

      }
    )
  }

  #auto scalling

resource "aws_autoscaling_group" "backend" {
  name                      = "${var.project}-${var.env}-${var.common_tags.Component}"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 1
  #here we should give target grp parameter inorder to add to specific tgrp
  target_group_arns = [aws_lb_target_group.backend.arn]
    launch_template {
    id      = aws_launch_template.backend.id
    version = "$Latest"
  }
  vpc_zone_identifier       = split(",",data.aws_ssm_parameter.private_subnet_ids.value)

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["launch_template"]
  }


  tag {
    key                 = "Name"
    value               = "${var.project}-${var.env}-${var.common_tags.Component}"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "Project"
    value               = "${var.project}"
    propagate_at_launch = false
  }
}

  
#autoscalling policy

resource "aws_autoscaling_policy" "backend" {
  name                   = "${var.project}-${var.env}-${var.common_tags.Component}"
  policy_type = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.backend.name

    #cpu utilisation

   target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 10.0
  }
}


#attatch rule

resource "aws_lb_listener_rule" "backend" {
  listener_arn = data.aws_ssm_parameter.alb_listener_arn.value
  priority     = 100 #less number will be first validated.

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend.arn
  }

#host path
  condition {
    host_header {
      values = ["backend.app-${var.env}.${var.zone_name}"]
    }
}
}

