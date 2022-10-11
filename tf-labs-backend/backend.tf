terraform {
  backend "s3" {
    bucket = "ta-labs-test-terraform-tfstates-342055123193"
    key    = "sprint1/week2/training-terraform/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}