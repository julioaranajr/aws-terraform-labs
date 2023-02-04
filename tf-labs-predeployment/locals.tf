
locals {
  project_name           = "Talent-Academy"
  environment            = "Test"
  challenge              = "AWS-Labs"
  region                 = "eu-central-1"
  github_role_name       = "Github-OIDC"
  thumbprint             = "6938fd4d98bab03faadb97b34396831e3780aea1"


  tags = {
    ProjectName = local.project_name
    Environment = local.environment
    Challenge   = local.challenge
  }
}
