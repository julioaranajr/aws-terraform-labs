# RESOURCE  "RESOURCE_TYPE"     "RESOURCE_NAME"
resource "aws_s3_bucket" "ta_test_backend_bucket" {
  bucket = "ta-labs-test-terraform-tfstates-342055123193"

  # META-DATA
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name        = "ta-labs-test-terraform-tfstates-342055123193"
    Environment = "Test"
    Team        = "Talent-Academy"
    Owner       = "Julio"
  }
}

resource "aws_s3_bucket_versioning" "version_my_bucket" {
  bucket = aws_s3_bucket.ta_test_backend_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_dynamodb_table" "terraform_lock_tbl" {
  name           = "terraform-lock"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags           = {
    Name = "terraform-lock"
  }
}