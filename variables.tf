variable "AWS_REGION" {
  type    = string
  default = "af-south-1"
}


variable "public_key" {
  type    = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClrmad9GFud/ouxXKIRgbJp1O7DrKLqV5VWLKndOMpJTGecRePoJiJk1Lclq5uiYhytyj6ivnD6OYjg7/gqk3CR2puehQvKDkCmCRo2Ol2OEQj7Awjt1JbRdt17e7G73uC8aRj95NIKewIuxt12D5jbjERo/z830g3Fc4qbRtfX0jN2av8uyUvCsZHfx0jAy4prEWbbA3g3EKU+5NCt4iRmgype4nwT5UEyYRdHmfjRddZ0TAVKY/6t1w5BpUiNZDrGGx3XXOIarU9MC3No+8ZD2OitHVfJyR7VULNJDdgfsPUFT2zr/dDfnXHLPgA+i5UUZ1sYaCaqDAlb1lJPHaTVd4+ktgZSXoaKddnFWibYdWJi8Lly3PysztnH9Hv1k/eamqXQv8sPom1qg09zWLLsrzKF5O/IYDXyp3LKL2+5xa4Mfo+BDQyRGInaPMmlwdoGWcPXg1NrWPu3G7hLP+gQzXE6hXD/vjrwhQkpLecnF1Azg7ThyWdWGjWamgBgeM= kodesh-pc@LNX-Jeeng-kpupik"
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ami-030b8d2037063bab3"
}


# variable "availability_zone" {
#   type    = string
#   default = "af-south-1a"
# }


# variable "vpc" {
#   type    = string
#   default = "10.0.0.0/16"
# }


# variable "private_ips" {
#   type    = list(string)
#   default = ["10.0.1.50"]
# }


# variable "key_name" {
#   type    = string
#   default = "aws_key"
# }
