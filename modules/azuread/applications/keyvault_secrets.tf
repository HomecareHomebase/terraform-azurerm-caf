
resource "azurerm_key_vault_secret" "client_id" {
  for_each = try(var.settings.keyvaults, {})

  name         = join("-", compact([try(each.value.secret_prefix, ""), "client-id", try(each.value.secret_suffix, "")]))
  value        = azuread_application.app.application_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id

  lifecycle {
    ignore_changes = [
      value
    ]
  }

}

resource "azurerm_key_vault_secret" "client_secret" {
  for_each        = try(var.settings.keyvaults, {})
  name            = join("-", compact([try(each.value.secret_prefix, ""), "client-secret", try(each.value.secret_suffix, "")]))
  value           = azuread_service_principal_password.pwd.value
  key_vault_id    = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
  expiration_date = timeadd(time_rotating.pwd.id, format("%sh", local.password_policy.expire_in_days * 24))
}

resource "azurerm_key_vault_secret" "tenant_id" {
  for_each     = try(var.settings.keyvaults, {})
  name         = join("-", compact([try(each.value.secret_prefix, ""), "tenant-id", try(each.value.secret_suffix, "")]))
  value        = var.client_config.tenant_id
  key_vault_id = try(each.value.lz_key, null) == null ? var.keyvaults[var.client_config.landingzone_key][each.key].id : var.keyvaults[each.value.lz_key][each.key].id
}