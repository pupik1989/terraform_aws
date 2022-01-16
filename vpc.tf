resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
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

resource "aws_network_interface" "foo" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips     = var.private_ips
  security_groups = [aws_security_group.allow_web.id]
}

resource "aws_eip" "lb" {
  # instance   = data.aws_ami.ubuntu.id
  vpc               = true
  # network_interface = aws_network_interface.foo.id
  depends_on        = [aws_internet_gateway.gw]
}

# resource "aws_eip_association" "eip_assoc" {
#   instance_id   = aws_network_interface.foo.id
#   allocation_id = aws_eip.lb.id
# }
