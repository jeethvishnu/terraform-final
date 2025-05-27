#alb
resource "aws_lb" "alb" {
  name               = "${var.project}-${var.env}-alb"
  #private alb so keep true
  internal           = true
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.alb-sg_id.value]
  subnets            =  split(",",data.aws_ssm_parameter.private_subnet_ids.value) #create in private subnet, for alb min 2 subnets

  enable_deletion_protection = false



  tags = merge(
    var.common_tags,
    {
        Name = "${var.project}-${var.env}-alb"
    }
  )
}

#listener


resource "aws_lb_listener" "http" {
    #we are attatching our lb under lb arn
  load_balancer_arn = aws_lb.alb.arn #replace with your lb name
  port              = "80"
  protocol          = "HTTP" #for http no need of certifications

  default_action {
    type = "fixed-response"
    
    fixed_response {
      content_type = "text/html"
      message_body = "<h1>Fixed response from APP ALB</h1>"
      status_code  = "200"
    }

    
  }
}

#instead of dns we are creating record for user friendly
module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 3.0"

 zone_name = var.zone_name

  records = [
    {
      name    = "*.app-${var.env}"
      type    = "A"
      allow_overwrite = true
      alias = {
        name = aws_lb.alb.dns_name
        zone_id = aws_lb.alb.zone_id
      }
      
    }
  ]
} 