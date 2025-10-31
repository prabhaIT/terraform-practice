variable "ami_id" {
    description = "passing ami values"
    default = ""
    type = string
  
}
variable "type" {
    description = "passing instance type"
    default = ""
    type = string
  
}
variable "vpc_cidr" {
description = "CIDR block for VPC"
type = string  
}