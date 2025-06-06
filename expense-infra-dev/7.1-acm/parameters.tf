resource "aws_ssm_parameter" "acm_certificate_arn" {
    name = "/${var.project}/${var.env}-acm_certificate_arn"
    type = "string"
    value = aws_acm_certificate.expense.arn
  
}