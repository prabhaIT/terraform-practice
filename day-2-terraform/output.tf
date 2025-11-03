output "publicIp" {
    value = aws_instance.name.public_ip
}
output "az" {
    value = aws_instance.name.availability_zone
  }
  output "privateIP" {
    value = aws_instance.name.private_ip
    
  } 
  output "Subnet" {
    value = aws_instance.name.subnet_id 
}
output "vpc" {
    value = aws_instance.name.vpc_security_group_ids
  
}
  
