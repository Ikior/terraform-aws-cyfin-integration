# This resource directly creates the IAM Role using the native AWS provider.
resource "aws_iam_role" "cyfin_readonly_role" {
  name = "CyFin-ReadOnly-Role"

  # This defines who can assume the role. It is our trust policy.
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [
      {
        Effect    = "Allow",
        Action    = "sts:AssumeRole",
        Principal = { AWS = "arn:aws:iam::003457291014:root" }, # IMPORTANT: shadowId
        Condition = {
          StringEquals = { "sts:ExternalId" = var.external_id }
        }
      }
    ]
  })
}

# This resource attaches the first required policy to the role.
resource "aws_iam_role_policy_attachment" "security_audit_attach" {
  role       = aws_iam_role.cyfin_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/SecurityAudit"
}

# This resource attaches the second required policy.
resource "aws_iam_role_policy_attachment" "view_only_attach" {
  role       = aws_iam_role.cyfin_readonly_role.name
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}
