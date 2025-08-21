# variables.tf
variable "cyfin_api_token" {
  type        = string
  description = "Your personal Onboarding Token provided by the CyFin dashboard."
  sensitive   = true # This hides it from logs
}

variable "external_id" {
  type        = string
  description = "The External ID for this integration, also provided by the CyFin dashboard."
}
