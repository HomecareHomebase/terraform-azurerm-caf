resource "azuread_group" "group" {

  # TODO - TANNER - DOUBLE CHECK
  display_name            = var.global_settings.passthrough ? format("%s", var.azuread_groups.name) : format("%s%s", try(format("%s-", var.global_settings.prefixes.0), ""), var.azuread_groups.name)
  description             = lookup(var.azuread_groups, "description", null)
  prevent_duplicate_names = lookup(var.azuread_groups, "prevent_duplicate_names", null)

}

locals {
  prefix = try(var.global_settings.prefix, null) == null ? "" : var.global_settings.prefix.0
  suffix = try(var.global_settings.suffix, null) == null ? "" : var.global_settings.suffix.0
}
