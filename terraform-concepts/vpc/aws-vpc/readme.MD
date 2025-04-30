#custom aws vpc module


This module is developed for joindevops.com. We are creating following resources. This module creates resources in first 2 AZ for HA.

*vpc
*internet gateway
*interbet and vpc attatchemnets
*2 public subnet
*2 private subnet
*2 database subnet
*EIP
*nat gateway
*public route table
*private route table
*db route yable
*route table and subnet associations
*routes in all tables
*peering if required for user
*rotes of peering in requestor asn acceptor vpc
*database subnet grps

##inputs##
. project name(r)
. env {op}
. common tags (r) type:map
. vpc_cidr {o}: def.vals 10.0.0.0/16. type str
. enable_dns_hostname {op} default is true type bool.

