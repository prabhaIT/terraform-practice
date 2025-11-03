module "deva" {
    source = "../day-7-modules"
    ami = var.ami
    instance_count = var.instance_count
    type = var.type
    tags = var.tags
  
}