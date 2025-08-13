output "cyfin_role_arn" {
  description = "The Amazon Resource Name (ARN) of the created IAM role for CyFin."
  value       = aws_iam_role.cyfin_readonly_role.arn
}