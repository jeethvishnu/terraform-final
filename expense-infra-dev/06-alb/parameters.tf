resource "aws_ssm_parameter" "app_alb_listener_arn" {
  name  = "/${var.project}/${var.env}/app_alb_listener_arn"
  type  = "String"
  value = aws_lb_listener.http.arn
}