# this we are keeping bcs sg id should come out in order to keep in ssm parameter we need to expose using outputs.then module user can catch it and they can keep itin parameter store.
output "sg_id" {
    value = aws_security_group.allow_tls.id
  
}