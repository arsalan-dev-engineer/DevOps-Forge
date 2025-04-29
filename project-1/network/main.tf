resource    "aws_vpc" "myvpc_m" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "publicSebnet" {

  vpc_id = aws_vpc.myvpc_m.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "my-subnet-1"
  }
}


resource "aws_subnet" "privateSubnet" {

  vpc_id = aws_vpc.myvpc_m.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "my-subnet-2"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id=aws_vpc.myvpc_m.id
}


resource "aws_route_table" "PublicRT" {
  vpc_id=aws_vpc.myvpc_m.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.publicSebnet.id
  route_table_id = aws_route_table.PublicRT.id
}


