resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "${var.project_name} - vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "${var.project_name} - igw"
    }
}

data "aws_availability_zones" "vailability_zones" {
    state = "available"
}

resource "aws_subnet" "public_subnet_az1" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = data.aws_availability_zones.vailability_zones.names[0]
    cidr_block = var.public_subnet_az1
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name} - public_subnet_az1"
    }
}
resource "aws_subnet" "public_subnet_az2" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = data.aws_availability_zones.vailability_zones.names[1]
    cidr_block = var.public_subnet_az2
    map_public_ip_on_launch = true
    tags = {
        Name = "${var.project_name} - public_subnet_az1"
    }
}

resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.project_name} - public_route_table"
    }
}

resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet_az1.id
}

resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
    route_table_id = aws_route_table.public_route_table.id
    subnet_id = aws_subnet.public_subnet_az2.id
}

resource "aws_subnet" "private_subnet_az1" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = data.aws_availability_zones.vailability_zones.names[0]
    cidr_block = var.private_subnet_az1
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project_name} - private_subnet_az1"
    }
}

resource "aws_subnet" "private_subnet_az2" {
    vpc_id = aws_vpc.vpc.id
    availability_zone = data.aws_availability_zones.vailability_zones.names[1]
    cidr_block = var.private_subnet_az2
    map_public_ip_on_launch = false
    tags = {
        Name = "${var.project_name} - private_subnet_az2"
    }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az1
  availability_zone        = data.aws_availability_zones.vailability_zones.names[0]
  map_public_ip_on_launch  = true

  tags      = {
    Name = "${var.project_name} - private_data_subnet_az1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                   = aws_vpc.vpc.id
  cidr_block               = var.private_data_subnet_az2
  availability_zone        = data.aws_availability_zones.vailability_zones.names[1]
  map_public_ip_on_launch  = false

  tags      = {
    Name = "${var.project_name} - private_data_subnet_az1"
  }
}