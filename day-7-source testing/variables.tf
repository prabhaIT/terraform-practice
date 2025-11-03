variable "ami" {
    description = "value passing for ami"
    default = ""
    type = string
  
}
variable "type" {
  
  description = " value passing for instance type"
  default = ""
  type = string
}
variable "instance_count" {
    description = "passing values for no.instances"
    default = 1
    type = number
  
}
variable "tags" {
    description = "name for server"
    
    type = map(string)
  default = {
    Name = "devansh"
  }
}