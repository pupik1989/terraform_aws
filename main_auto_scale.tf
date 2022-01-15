resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = var.public_key
}


resource "aws_instance" "web_app-2" {
  ami           = var.instance_name
  instance_type = "t3.micro"
  tags = {
    Name = "auto_scale_instance"
  }
}

