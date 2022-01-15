# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.27"
#     }
#   }
#   required_version = ">= 0.14.9"
# }

# provider "aws" {
#   profile = "default"
#   region  = "af-south-1"
# }


# resource "aws_vpc" "my_vpc" {
#   cidr_block = var.vpc
# }

# resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.my_vpc.id
# }

# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.my_vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.gw.id
#   }
# }

# resource "aws_subnet" "my_subnet" {
#   vpc_id            = aws_vpc.my_vpc.id
#   cidr_block        = "10.0.1.0/24"
#   availability_zone = var.availability_zone

#   tags = {
#     Name = "web-app"
#   }
# }

# resource "aws_route_table_association" "public_rt_a" {
#   subnet_id      = aws_subnet.my_subnet.id
#   route_table_id = aws_route_table.public_rt.id
# }

# resource "aws_security_group" "allow_web" {
#   name        = "allow_web"
#   description = "Allow web traffic"
#   vpc_id      = aws_vpc.my_vpc.id

#   ingress {
#     description = "HTTPS traffic"
#     from_port   = 443
#     to_port     = 443
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   ingress {
#     description = "HTTP traffic"
#     from_port   = 80
#     to_port     = 80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   ingress {
#     description = "SSH traffic"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
# }

# resource "aws_network_interface" "foo" {
#   subnet_id       = aws_subnet.my_subnet.id
#   private_ips     = var.private_ips
#   security_groups = [aws_security_group.allow_web.id]
# }

# resource "aws_eip" "lb" {
#   instance   = aws_instance.server_app2.id
#   vpc        = true
#   depends_on = [aws_internet_gateway.gw]
# }

# resource "aws_instance" "web_app-1" {
#   ami           = var.instance_name
#   instance_type = "t3.micro"
#   key_name      = "aws_key"
#   tags = {
#     Name = "main instance"
#   }

#   network_interface {
#     network_interface_id = aws_network_interface.foo.id
#     device_index         = 0
#   }
#   user_data = <<-EOF
#               #! /bin/bash
#               sudo apt-get update
#               sudo apt-get install -y nginx
#               sudo systemctl start nginx
#               echo "<h1>Hello world</h1>" | sudo tee /var/www/html/index.nginx-debian.html
#               EOF
# }


# resource "aws_key_pair" "key" {
#   key_name   = var.key_name
#   public_key = var.public_key
# }
