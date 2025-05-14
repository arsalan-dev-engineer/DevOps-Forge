resource    "aws_vpc" "website-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-website-vpc"
  }
}

# Get list of AZs dynamically
data "aws_availability_zones" "available" {
  state = "available"
}

# public subnet A
resource "aws_subnet" "publicSubnetA" {

  vpc_id = aws_vpc.website-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone= data.aws_availability_zones.available.names[0] 

  tags = {
    Name = "my-public-subnet-A"
  }
}

# private subnet A
resource "aws_subnet" "privateSubnetA" {

  vpc_id = aws_vpc.website-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone= data.aws_availability_zones.available.names[0]

  tags = {
    Name = "my-private-subnet-A"
  }
}



# public subnet B
resource "aws_subnet" "publicSubnetB" {

  vpc_id = aws_vpc.website-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone= data.aws_availability_zones.available.names[1] 

  tags = {
    Name = "my-public-subnet-B"
  }
}



# private subnet B
resource "aws_subnet" "privateSubnetB" {

  vpc_id = aws_vpc.website-vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone= data.aws_availability_zones.available.names[1]

  tags = {
    Name = "my-private-subnet-B"
  }
}




resource "aws_internet_gateway" "igw" {
  vpc_id=aws_vpc.website-vpc.id
}


resource "aws_route_table" "PublicRT" {
  vpc_id=aws_vpc.website-vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}


#public route table for public subnet A
##publicSubnetA is now linked to the route table that 
##enables internet access.
resource "aws_route_table_association" "PublicRTassociationA" {
  subnet_id = aws_subnet.publicSubnetA.id
  route_table_id = aws_route_table.PublicRT.id
}

resource "aws_route_table_association" "PublicRTassociationB" {
  subnet_id      = aws_subnet.publicSubnetB.id
  route_table_id = aws_route_table.PublicRT.id
}








# Elastic IP for NAT Gateway in AZ A
resource "aws_eip" "eipA" {

  tags = {
    Name = "EIP for NAT Gateway"
  }
}

# Elastic IP for NAT Gateway in AZ B
resource "aws_eip" "eipB" {

  tags = {
    Name = "EIP for NAT Gateway"
  }
}



##nat gateway for public subnet A
resource "aws_nat_gateway" "natA" {
  allocation_id = aws_eip.eipA.id
  subnet_id     = aws_subnet.publicSubnetA.id
  

  tags = {
    Name = "gw NAT A"
  }

  #adding dependency to ensure igw is created
  depends_on = [aws_internet_gateway.igw]
}

##nat gateway for public subnet B
resource "aws_nat_gateway" "natB" {
  allocation_id = aws_eip.eipB.id
  subnet_id     = aws_subnet.publicSubnetB.id
  

  tags = {
    Name = "gw NAT B"
  }

  #adding dependency to ensure igw is created
  depends_on = [aws_internet_gateway.igw]
}


###route table for nat gateway A
resource "aws_route_table" "privateRT_A" {
  vpc_id=aws_vpc.website-vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natA.id
  }
}


###route table for nat gateway B
resource "aws_route_table" "privateRT_B" {
  vpc_id=aws_vpc.website-vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natB.id
  }
}


resource "aws_route_table_association" "PrivateRT_A_associationA" {
  subnet_id = aws_subnet.privateSubnetA.id
  route_table_id = aws_route_table.privateRT_A.id
}


resource "aws_route_table_association" "PrivateRT_B_associationB" {
  subnet_id = aws_subnet.privateSubnetB.id
  route_table_id = aws_route_table.privateRT_B.id
}


