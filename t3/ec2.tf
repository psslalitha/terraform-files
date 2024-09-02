provider "aws" {
    region = "ap-south-1"
  
}

resource "aws_instance" "tec2" {
    ami = "ami-0522ab6e1ddcc7055"
    key_name = "nexus"
    instance_type = "t2.medium" 
}