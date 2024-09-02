provider "aws" {
  region = "ap-south-1"
}

variable "var1" {
  type        = string
  description = "Enter a value for AMI"
}

output "output1" {
  value = var.var1
}

variable "var2" {
  type        = string
  description = "Enter a value for instance type"
}

output "output2" {
  value = var.var2
}

variable "var3" {
  type        = number
  description = "Enter a value for volume"
}

output "output3" {
  value = var.var3
}



