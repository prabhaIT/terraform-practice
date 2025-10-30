terraform {
  backend "s3" {
    bucket = "prabha-terraform-s3-bucketsdfghj"
    key ="day-4/terraform.tfstate"
    use_lockfile = true
    region ="ap-south-1"
    
    
  }
}