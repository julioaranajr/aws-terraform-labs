terraform {
    backend "s3" {
        bucket = "ta-labs-test-terraform-tfstates-342055123193"
        key = "sprint1/week6/vpc/terraform.tfstates"
        dynamodb_table = "terraform-lock"
    }
}