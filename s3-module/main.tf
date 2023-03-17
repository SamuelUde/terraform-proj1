#1. Create s3 bucket for state storage
resource "aws_s3_bucket" "env_backend" {
  bucket = "Bootcamp29-${random_integer.bucket_name.result}-${var.name}"

  /*tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }*/
}

#2. Bucket ACL
resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.env_backend.id
  acl    = var.acl
}

#3. Bucket versioning

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.env_backend.id
  versioning_configuration {
    status = var.versioning
  }
}

/*resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}*/

#4. Bucket encryption
resource "aws_s3_bucket" "mybucket" {
  bucket = "env_backend"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.mykey.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
#5. Bucket encryption with KMS
resource "aws_kms_key" "mykey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = var.mykey_expiring
}

#6. Bucket name conforms to Random integer
resource "random_integer" "bucket_name" {
  min = 1
  max = 100
  keepers = {
    # Generate a new integer each time we switch to a new listener ARN
    bucket_name = var.name
    #listener_arn = var.listener_arn
  }
}