terraform {
    backend "s3" {
        bucket = "sreenivasulu.co.in"
        key = "day-7/terraform.tfstate"
        use_lockfile = true
        region = "ap-south-1"
      
    }
}