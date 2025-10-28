# Create VPC
resource "aws_vpc" "prabha_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "prabha-vpc"
  }
}

# Create Subnet
resource "aws_subnet" "prabha_subnet" {
  vpc_id                  = aws_vpc.prabha_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "prabha-subnet"
  }
}
 resource "aws_instance" "name" {
    ami = "ami-00af95fa354fdb788"
    instance_type = "t3.micro"
   
 }