variable "external_id" {
  description = "The unique External ID provided by the CyFin platform for secure role assumption. You can find this on the 'Connect Account' page in CyFin."
  type        = string
  sensitive   = true # Marks the variable as sensitive to prevent it from being shown in logs.
}
