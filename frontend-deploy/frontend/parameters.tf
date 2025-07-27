resource "aws_ssm_parameter" "aws_lb_listener_arn" {
    name = "/${var.project}/${var.env}/alb_listener_arn"
    type = "string"
    value = aws_lb_listener.http.arn
  
}

resource "aws_ssm_parameter" "aws_lb_listener_arn_https" {
    name = "/${var.project}/${var.env}/alb_listener_arn_https"
    type = "string"
    value = aws_lb_listener_rule.frontend
  
}