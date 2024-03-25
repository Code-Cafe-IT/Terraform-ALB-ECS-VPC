resource "aws_eip" "eip_for_natgw" {
  domain = "vpc"

  tags = {
    Name = "natg gw - eip"
  }
}

resource "aws_nat_gateway" "nat_gw_az1" {
  allocation_id = aws_eip.eip_for_natgw.id
  subnet_id = var.public_subnet_az1
  tags = {
    Name = "nat gw az1 "
  }

  depends_on = [ var.igw ]
}

resource "aws_route_table" "private_route_table_az1" {
  vpc_id = var.cidr_block_id 
  
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_az1.id
  }
  tags = {
    Name = "private routeable"
  }
}

resource "aws_route_table_association" "private_app_subnet_az1_rtb_association" {
  subnet_id = var.private_subnet_az1_id
  route_table_id = aws_route_table.private_route_table_az1.id
}

resource "aws_route_table_association" "private_app_subnet_az2_rtb_association" {
  subnet_id = var.private_subnet_az2_id
  route_table_id = aws_route_table.private_route_table_az1.id
}




