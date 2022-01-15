variable "AWS_REGION" {
  type    = string
  default = "af-south-1"
}


variable "key_name" {
  type    = string
  default = "aws_key"
}

variable "public_key" {
  type    = string
  default = "aws_key.pub"
}

variable "instance_name" {
  type    = string
  default = "ami-030b8d2037063bab3"
}


variable "availability_zone" {
  type    = string
  default = "af-south-1a"
}

variable "private_ips" {
  type    = list(string)
  default = ["10.0.1.50"]
}
