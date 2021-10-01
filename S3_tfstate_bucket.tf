resource "aws_s3_bucket" "tfstate" {
  bucket = var.tfstate_bucket_name

  acl    = "private"
  
  // Set this to true during testing, set this to false in prod!
  force_destroy = false

  versioning {
    enabled = true
  }

  // Uncomment the below to prevent destroying:
  lifecycle {
    prevent_destroy = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket                  = aws_s3_bucket.tfstate.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
