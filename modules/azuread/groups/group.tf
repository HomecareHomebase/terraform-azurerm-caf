resource "azuread_group" "group" {
  // TANNER - EXAMPLE OF NAME CONCAT
  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : join("-", compact(concat(var.global_settings.prefixes == null ? [] : var.global_settings.prefixes, [var.azuread_groups.name], var.global_settings.suffixes == null ? [] : var.global_settings.suffixes)))
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)

}