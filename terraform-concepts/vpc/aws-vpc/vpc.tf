#vpc

resource "aws_vpc" "main" {
  cidr_block       = var.cidr
  instance_tenancy = "default"
  enable_dns_hostnames  = var.enable_dns_hostnames #to enable/disable DNS hostnames


  tags = merge(
    var.common_tags,var.vpc_tags,
    {
      Name = local.resource_name
    }
  )
}

#internet gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.resource_name
    }
  )

} 

#public subnet

resource "aws_subnet" "public" {
  count = length(var.public_cidrs)
  availability_zone = local.az_names[count.index]
  map_public_ip_on_launch = true #we should keep this as true because for public this has to be enabled
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_cidrs[count.index]


tags = merge(
    var.common_tags,
    var.public_cidrs_tags,
    {
      Name = "${local.resource_name}-public-${local.az_names[count.index]}"
    }
  )
}

#private subnets

resource "aws_subnet" "private" {
  count = length(var.private_cidrs)
  availability_zone = local.az_names[count.index]
 # map_public_ip_on_launch = false
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidrs[count.index]


tags = merge(
    var.common_tags,
    var.private_cidrs_tags,
    {
      Name = "${local.resource_name}-private-${local.az_names[count.index]}"
    }
  )
}

#db subnets

resource "aws_subnet" "database" {
  count = length(var.database_cidrs)
  availability_zone = local.az_names[count.index]
 # map_public_ip_on_launch = false
  vpc_id     = aws_vpc.main.id
  cidr_block = var.database_cidrs[count.index]


tags = merge(
    var.common_tags,
    var.database_cidrs_tags,
    {
      Name = "${local.resource_name}-database-${local.az_names[count.index]}"
    }
  )
}

#subnet grp for db
resource "aws_db_subnet_group" "default" {
  name       = "${local.resource_name}"
  subnet_ids = aws_subnet.database[*].id
  tags = merge(
    var.common_tags,
    var.database_subnet_grp_tags,
    {
      Name = "${local.resource_name}"
    }
  )
  
}
#elastic ip

resource "aws_eip" "nat" {
  domain   = "vpc"
}

#nat

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id # if we give 0 here it will be into us-east-1a

  tags = merge(
    var.common_tags,
    var.nat_tags,
    {
      Name = "${local.resource_name}"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw] # this is explicit dependency first create ig then nat gw
}

#public route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_rtable_tags,
    {
      Name = "${local.resource_name}-public"
    }
  )

}

#private route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_rtable_tags,
    {
      Name = "${local.resource_name}-private"
    }
  )

}

#db routee table
resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.database_rtable_tags,
    {
      Name = "${local.resource_name}-database"
    }
  )

}

#routes

resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route" "private_route_nat" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

resource "aws_route" "database_route" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
}

#route table and public subnet association
resource "aws_route_table_association" "public" {
  count = length(var.public_cidrs)
  subnet_id      = element(aws_subnet.public[*].id,count.index) #element is function used when we want to take a element from a list.
  route_table_id = aws_route_table.public.id
}

#private
resource "aws_route_table_association" "private" {
  count = length(var.private_cidrs)
  subnet_id      = element(aws_subnet.private[*].id,count.index)
  route_table_id = aws_route_table.private.id
}

#database
resource "aws_route_table_association" "database" {
  count = length(var.database_cidrs)
  subnet_id      = element(aws_subnet.database[*].id,count.index)
  route_table_id = aws_route_table.database.id
}

