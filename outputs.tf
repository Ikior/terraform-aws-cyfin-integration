# outputs.tf

output "cyfin_role_arn" {
  description = "The Amazon Resource Name (ARN) of the created IAM role for CyFin."
  value       = module.iam_role_for_cyfin.iam_role_arn
}
