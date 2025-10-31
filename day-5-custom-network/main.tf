#creation of vpc
resource "aws_vpc" "name" {
cidr_block = "10.0.0.0/16"
tags ={ 
    name = "prabhakar"
}  
}
#subnet creation public
resource "aws_subnet" "public_ip" {
vpc_id = aws_vpc.name.id
cidr_block ="10.0.0.0/24"
availability_zone = "ap-south-1a"  
tags ={
    name = "prabha-public-1"
}
}
#subnet creation-2
resource "aws_subnet" "public_ip-2" {
vpc_id = aws_vpc.name.id
cidr_block ="10.0.1.0/24"
availability_zone = "ap-south-1b"  
tags ={
    name = "prabha-public-2"
}
}
#private subnet-1
resource "aws_subnet" "private_ip" {
vpc_id = aws_vpc.name.id
cidr_block ="10.0.4.0/24"
availability_zone = "ap-south-1a"  
tags ={
    name = "prabha-private-1"
}
}
#private subnet -2
resource "aws_subnet" "private_ip-2" {
vpc_id = aws_vpc.name.id
cidr_block ="10.0.2.0/24"
availability_zone = "ap-south-1b"  
tags ={
    name = "prabha-private-2"
}
}
#internet gateway  creation and vpc attach
 resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.name.id
  tags = {
    name = "prabha-ig"
  }
}
#route table and subnet association
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig.id
    }
  
}
resource "aws_route_table_association" "public" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.public_ip.id
    
}
# security group creation
resource "aws_security_group" "prabha_sg" {
    ingress {
        description = "allow ssh"
        from_port = "80"
        to_port = "80"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  

ingress {
        description = "allow HTTPS"
        from_port = "443"
        to_port = "443"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }
      egress {
        description = "allow"
        from_port = "0"
        to_port = "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
    

}
# creation aws instance
# Public EC2
resource "aws_instance" "ec2" {
  ami                    = "ami-00af95fa354fdb788"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.prabha_sg.id]
  subnet_id              = aws_subnet.public_ip.id

  associate_public_ip_address = true

  tags = {
    Name = "public-ec2"
  }
}

# Private EC2
resource "aws_instance" "ec2-2" {
  ami                    = "ami-00af95fa354fdb788"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.prabha_sg.id]
  subnet_id              = aws_subnet.private_ip.id
  associate_public_ip_address = false

  tags = {
    Name = "private-ec2"
  }
}

