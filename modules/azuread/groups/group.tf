resource "azuread_group" "group" {

  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : join("-", compact(concat(try(var.global_settings.prefixes, []), [var.azuread_groups.name], try(var.global_settings.suffixes, []))))
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)

}