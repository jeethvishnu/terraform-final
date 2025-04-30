#vpc

resource "aws_vpc" "main" {
  cidr_block       = var.cidrs
  instance_tenancy = "default"
  enable_dns_hostnames = var.dns_hostname

  tags = merge(
    var.common_tags,
    var.vpc_tags,
    {
        Name = local.resource_name
    }
  )
}

#igw

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,var.igw_tags,
    {
        Name = local.resource_name
    }
  )
}

#public subnet

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_cidr
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"

  tags = merge(
    var.pub_sub_tags,var.common_tags,
    {
        Name = "${local.resource_name}-public"
    }
  )
}

#private subent

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_cidr
  availability_zone = "us-east-1a"

  tags = merge(
    var.private_sub_tags,var.common_tags,
    {
        Name = "${local.resource_name}-private"
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
  subnet_id     = aws_subnet.public.id

  tags = merge(
    var.common_tags,var.nat_tags,
    {
        Name = "${local.resource_name}"
    }
  )

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

#rtbales
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.pub_rtable_tags,
    {
        Name = "${local.resource_name}-public"
    }
  )

}

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


#routes

resource "aws_route" "public_rt" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route" "private_rt" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id

}

#route table and public subnet association

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
