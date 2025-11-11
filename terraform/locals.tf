# compute a reusable name prefix and common tags

locals {
  # name_prefix ensures consistent naming across modules
  name_prefix = "${var.project_name}-${var.environment}"

  # common_tags merges a standard tag with user-provided tags
  common_tags = merge({ ManagedBy = "Terraform" }, var.tags)
}