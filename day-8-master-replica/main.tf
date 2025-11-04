

# ---------- VPC ----------
resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "rds-vpc"
  }
}

# ---------- Subnets ----------
resource "aws_subnet" "rds_subnet_1" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "rds-subnet-1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "rds-subnet-2"
  }
}

# ---------- Subnet Group ----------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]

  tags = {
    Name = "rds-subnet-group"
  }
}

# ---------- Security Group ----------
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.rds_vpc.id

  ingress {
    description = "MySQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You can restrict this to your IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# ---------- RDS Instance ----------
resource "aws_db_instance" "rds_instance" {
  identifier              = "prabhadb"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"        # manual username
    manage_master_user_password = true      # secrets manager managed password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
  storage_type            = "gp2"

  tags = {
    Name = "my-rds-db"
  }
}



# ---------- VPC ----------
resource "aws_vpc" "rds_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "rds-vpc"
  }
}

# ---------- Subnets ----------
resource "aws_subnet" "rds_subnet_1" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "rds-subnet-1"
  }
}

resource "aws_subnet" "rds_subnet_2" {
  vpc_id                  = aws_vpc.rds_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "rds-subnet-2"
  }
}

# ---------- Subnet Group ----------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [aws_subnet.rds_subnet_1.id, aws_subnet.rds_subnet_2.id]

  tags = {
    Name = "rds-subnet-group"
  }
}

# ---------- Security Group ----------
resource "aws_security_group" "rds_sg" {
  name        = "rds-sg"
  description = "Allow MySQL inbound traffic"
  vpc_id      = aws_vpc.rds_vpc.id

  ingress {
    description = "MySQL access"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # You can restrict this to your IP for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}

# ---------- RDS Instance ----------
resource "aws_db_instance" "rds_instance" {
  identifier              = "prabhadb"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = "admin"        # manual username
    manage_master_user_password = true      # secrets manager managed password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = true
  multi_az                = false
  storage_type            = "gp2"
apply_immediately = true
  tags = {
    Name = "my-rds-db"
  }
}


# #resource "aws_db_instance" "read_replica" {
#   allocated_storage       = 20
#   identifier                 = "prabhadb"
#   replicate_source_db         = aws_db_instance.rds_instance.id
#   instance_class              = "db.t3.micro"
#   publicly_accessible         = true
#   skip_final_snapshot         = true
#   auto_minor_version_upgrade  = true

#   # Optional: specify storage type and region
#   storage_type = "gp2"

#   tags = {
#     Name = "read-replica"
#   }
# }









resource "aws_internet_gateway" "prabha_ig" {
    vpc_id = aws_vpc.rds_vpc.id
  
}
resource "aws_route_table" "prabha_rt" {
    vpc_id = aws_vpc.rds_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prabha_ig.id
    }

}
  resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.prabha_rt.id
    subnet_id = aws_subnet.rds_subnet_1.id
    
    
  }










resource "aws_internet_gateway" "prabha_ig" {
    vpc_id = aws_vpc.rds_vpc.id
  
}
resource "aws_route_table" "prabha_rt" {
    vpc_id = aws_vpc.rds_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.prabha_ig.id
    }

}
  resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.prabha_rt.id
    subnet_id = aws_subnet.rds_subnet_1.id
    
    
  }
