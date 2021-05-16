output "id" {
  value = azurerm_linux_virtual_machine_scale_set.scale_set["linux"].id
}

output "unique_id" {
  value = azurerm_linux_virtual_machine_scale_set.scale_set["linux"].unique_id
}

output "os_type" {
  value = local.os_type
}

output "admin_username" {
  value       = var.settings.scale_set_settings["linux"].admin_username
  description = "Local admin username"
}

output "ssh_keys" {
  value = local.create_sshkeys ? {
    keyvault_id              = local.keyvault.id
    ssh_private_key_pem      = azurerm_key_vault_secret.ssh_private_key["linux"].name
    ssh_private_key_open_ssh = azurerm_key_vault_secret.ssh_public_key_openssh["linux"].name
  } : null
}
