# Create VPC
resource "aws_vpc" "prabha_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "prabha-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "prabha_subnet" {
  vpc_id                  = aws_vpc.prabha_vpc.id
  cidr_block              = aws_vpc.prabha_vpc.cidr_block
  
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "prabha-subnet"
  }
}
 resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.type
   
 }