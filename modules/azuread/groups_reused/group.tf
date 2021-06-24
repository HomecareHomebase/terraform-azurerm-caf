data "azuread_group" "group" {
  display_name     = var.azuread_groups.name
}