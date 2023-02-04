################################################################################
# GitHub OIDC Role
################################################################################

output "name" {
  description = "Name of IAM role"
  value       = try(aws_iam_role.github_actions.name, null)
}
output "arn" {
  description = "ARN of IAM role"
  value       = try(aws_iam_role.github_actions.arn, null)
}

output "path" {
  description = "Path of IAM role"
  value       = try(aws_iam_role.github_actions.path, null)
}

output "unique_id" {
  description = "Unique ID of IAM role"
  value       = try(aws_iam_role.github_actions.unique_id, null)
}
