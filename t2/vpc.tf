resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/24"

  tags ={
    name = "myvpc"
  }
}

resource "aws_subnet" "myvpc-subnet-public-1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "192.168.0.0/25"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags ={
    name = "myvpc-subnet-public-1"
  }
}

resource "aws_subnet" "myvpc-subnet-public-2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "192.168.0.128/25"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags ={
    name = "myvpc-subnet-public-2"
  }
}

resource "aws_internet_gateway" "myvpc-igw" {
  vpc_id = aws_vpc.myvpc.id

  tags ={
    name = "myvpc-igw"
  }
}

resource "aws_route_table" "rt-public-1" {
  vpc_id = aws_vpc.myvpc.id

  tags ={
    name = "rt-public-1"
  }
}

resource "aws_route" "myvpc-public-route-1" {
  route_table_id         = aws_route_table.rt-public-1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myvpc-igw.id

  
}

resource "aws_route_table_association" "myvpc-public-1" {
  route_table_id = aws_route_table.rt-public-1.id
  subnet_id      = aws_subnet.myvpc-subnet-public-1.id

}

resource "aws_route_table" "rt-public-2" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    name = "rt-public-2"
  }
}

resource "aws_route" "myvpc-public-route-2" {
  route_table_id         = aws_route_table.rt-public-2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myvpc-igw.id

}


resource "aws_route_table_association" "myvpc-public-2" {
  route_table_id = aws_route_table.rt-public-2.id
  subnet_id      = aws_subnet.myvpc-subnet-public-2.id
  
}

resource "aws_security_group" "myvpc-sg" {
  name        = "myvpc-default-sg"
  description = "myvpc default security group"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP for Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}