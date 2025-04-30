# TERRAFORM AWS EC2 module

## inputs:

* ami (Optional) : ami id is optional. default val is ami-09c813fb71547fc4f
* security_group_id (optional): list of security group ids. default is sg-07fad016c7fd8f34f

* instnce_type(optional) : default value is t2.micro.
* tags(optional) : default value is empty.

## outputs:
* public_ip: gives the pub ip
* private_ip: give the private ip
* id: gives the instance id


