# C:\IKIOR\terraform-aws-cyfin-integration\outputs.tf (Corrected Version)

output "cyfin_role_arn" {
  description = "The Amazon Resource Name (ARN) of the created IAM role for CyFin."
  value       = module.cyfin_assumable_role.iam_role_arn
}