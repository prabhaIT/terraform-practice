resource "aws_instance" "EC2" {
    ami = "ami-01760eea5c574eb86" 
    availability_zone = "ap-south-1a"
    associate_public_ip_address = true
    instance_type = "t3.micro"
    tags = {
        Name = "server"
    }

}