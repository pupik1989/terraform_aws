resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}


resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id
}


resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow web traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "HTTPS traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


resource "aws_instance" "web_app_2" {
  ami               = var.instance_name
  instance_type     = "t3.micro"
  availability_zone = var.availability_zone
  key_name          = var.key_name
  tags = {
    Name = "auto_scale_instance"
  }
  user_data = file("install_web_server.sh")
}


output "public_ip" {
  value = aws_instance.web_app_2.public_ip
}
