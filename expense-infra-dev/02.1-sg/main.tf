resource "aws_security_group" "allow_all" {
  name        = "allow-all"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value  # Make sure to set your VPC ID

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"       # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"       # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all"
  }
}