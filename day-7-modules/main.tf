resource "aws_instance" "ec2" {
 ami = var.ami
 instance_type = var.type
 count = var.instance_count
 tags = var.tags
}