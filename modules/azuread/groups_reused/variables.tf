variable "azuread_groups" {
  description = "Set of groups to be created."
}

variable "tenant_id" {
  description = "The tenant ID of the Azure AD environment where to create the groups."
  type        = string
}