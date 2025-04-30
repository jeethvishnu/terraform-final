# vpc peering creation
######### if count is set then its list means it can be 0 or 1 0r 2
resource "aws_vpc_peering_connection" "peering" {
  count = var.is_peering_yes ? 1 : 0
  #peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.acceptor_vpc == "" ? data.aws_vpc.default.id : var.acceptor_vpc  #reciever vpc
  vpc_id        = aws_vpc.main.id #requestor vpc
  auto_accept =  var.acceptor_vpc == "" ? true : false #auto accpet we can see under vpc peer module this helps like if we are accessing both in same vpc then it is useful or else manually they have to accept
  tags = merge(
    var.common_tags,
    var.is_peering_tags,
    {
      Name = "${local.resource_name}" #expense-dev
    }
  )
}

## generally whatever the subnets we want to give access those route tables only we have to add. here we'll add everything.
## count is useful to control when resource is required MANDATORY.
resource "aws_route" "public_peering" {
  count = var.is_peering_yes &&  var.acceptor_vpc == "" ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id  = aws_vpc_peering_connection.peering[0].id #from online in route module we can find this
}

resource "aws_route" "private_peering" {
  count = var.is_peering_yes &&  var.acceptor_vpc == "" ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id  = aws_vpc_peering_connection.peering[0].id #from online in route module we can find this
}

resource "aws_route" "database_peering" {
  count = var.is_peering_yes &&  var.acceptor_vpc == "" ? 1 : 0
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id  = aws_vpc_peering_connection.peering[0].id #from online in route module we can find this
}

#defualt vpc
#for every default vpc there will be main route table too
resource "aws_route" "default_peering" {
  count = var.is_peering_yes &&  var.acceptor_vpc == "" ? 1 : 0
  route_table_id            = data.aws_route_table.main.id #default vpc route
  destination_cidr_block    = var.cidr
  vpc_peering_connection_id  = aws_vpc_peering_connection.peering[0].id #from online in route module we can find this
}