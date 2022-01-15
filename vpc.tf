resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc
  tags = {
    Name = "my_vpc"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone

  tags = {
    Name = "web-app"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_internet_gateway"
  }
}


resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "my_route_table"
  }
}

resource "aws_route_table_association" "public_rt_a" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_eip" "lb" {
  instance   = aws_instance.web_app_2.id
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}
