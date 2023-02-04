# s3 bucket for backend
resource "aws_s3_bucket" "backend" {
  bucket = var.s3_bucket
}

# DynamoDB for tfstates
resource "aws_dynamodb_table" "backend" {
  name           = var.dynamodb_table
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Github OIDC Provider 
resource "aws_iam_openid_connect_provider" "github_default" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [local.thumbprint]
}

resource "aws_iam_role" "github_actions" {
  name               = local.github_role_name
  assume_role_policy = data.aws_iam_policy_document.github_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "github_role_attachment" {
  role       = aws_iam_role.github_actions.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
