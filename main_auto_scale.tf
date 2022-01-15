resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.public_key)
}


resource "aws_instance" "web_app-2" {
  ami               = var.instance_name
  instance_type     = "t3.micro"
  availability_zone = var.availability_zone
  tags = {
    Name = "auto_scale_instance"
  }
  user_data = file("install_web_server.sh")
}

