

# 1️⃣ Create S3 bucket (must be globally unique)
resource "aws_s3_bucket" "my_bucket" {
  bucket = "prabha-terraform-bucket-12345"

  tags = {
    Name        = "MyCompleteS3Bucket"
    Environment = "Dev"
  }
}

# 2️⃣ Enforce bucket ownership (disables ACLs completely — AWS best practice)
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# 3️⃣ Allow public access for static website (disable blocking)
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

# 4️⃣ Enable website hosting
resource "aws_s3_bucket_website_configuration" "website_hosting" {
  bucket = aws_s3_bucket.my_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# 5️⃣ Enable versioning (optional)
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.my_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# 6️⃣ Enable server-side encryption (SSE-S3)
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# 7️⃣ Upload static files (no ACLs needed!)
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "index.html"
  content      = "<h1>Hello from Terraform S3 Website!</h1>"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.my_bucket.id
  key          = "error.html"
  content      = "<h1>404 - Page Not Found</h1>"
  content_type = "text/html"
}

# 8️⃣ Public bucket policy (this replaces ACLs)
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.my_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = ["s3:GetObject"]
        Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
      }
    ]
  })
}

# 9️⃣ Output the website endpoint
output "website_url" {
  value = aws_s3_bucket_website_configuration.website_hosting.website_endpoint
}
