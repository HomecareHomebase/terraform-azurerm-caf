resource "tls_private_key" "ssh" {
  for_each = local.create_sshkeys ? var.settings.scale_set_settings : {}

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurecaf_name" "linux" {
  for_each = local.os_type == "linux" ? var.settings.scale_set_settings : {}

  name          = each.value.name
  resource_type = "azurerm_linux_virtual_machine_scale_set"
  prefixes      = var.global_settings.prefixes
  suffixes      = var.global_settings.suffixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurecaf_name" "linux_nic" {
  for_each = local.os_type == "linux" ? var.settings.scale_set_settings : {}

  name          = each.value.name
  resource_type = "azurerm_network_interface"
  prefixes      = var.global_settings.prefixes
  suffixes      = var.global_settings.suffixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_linux_virtual_machine_scale_set" "scale_set" {
  for_each = local.os_type == "linux" ? var.settings.scale_set_settings : {}

  name                = azurecaf_name.linux[each.key].result
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = each.value.sku
  instances           = try(each.value.instances, 0)
  admin_username      = each.value.admin_username
  tags                = merge(local.tags, try(each.value.tags, null))

  network_interface {
    name    = azurecaf_name.linux_nic[each.key].result
    primary = true

    ip_configuration {
      name      = azurecaf_name.linux_nic[each.key].result
      primary   = true
      subnet_id = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
    }
  }

  upgrade_mode                    = try(each.value.upgrade_mode, null)
  computer_name_prefix            = try(each.value.computer_name_prefix, null)
  eviction_policy                 = try(each.value.eviction_policy, null)
  max_bid_price                   = try(each.value.max_bid_price, null)
  priority                        = try(each.value.priority, null)
  provision_vm_agent              = try(each.value.provision_vm_agent, true)
  disable_password_authentication = try(each.value.disable_password_authentication, true)
  custom_data                     = try(each.value.custom_data, null) == null ? null : filebase64(format("%s/%s", path.cwd, each.value.custom_data))
  proximity_placement_group_id    = try(var.proximity_placement_groups[var.client_config.landingzone_key][each.value.proximity_placement_group_key].id, var.proximity_placement_groups[each.value.proximity_placement_groups].id, null)
  overprovision                   = try(each.value.overprovision, null)

  dynamic "admin_ssh_key" {
    for_each = lookup(each.value, "disable_password_authentication", true) == true ? [1] : []

    content {
      username   = each.value.admin_username
      public_key = local.create_sshkeys ? tls_private_key.ssh[each.key].public_key_openssh : file(var.settings.public_key_pem_file)
    }
  }

  os_disk {
    caching                   = try(each.value.os_disk.caching, null)
    storage_account_type      = try(each.value.os_disk.storage_account_type, null)
    # diff_disk_settings        = try(each.value.os_disk.diff_disk_settings, null)
    disk_encryption_set_id    = try(each.value.os_disk.disk_encryption_set_id, null)
    disk_size_gb              = try(each.value.os_disk.disk_size_gb, null)
    write_accelerator_enabled = try(each.value.os_disk.write_accelerator_enabled, false)

    dynamic "diff_disk_settings" {
      for_each = try(each.value.os_disk.diff_disk_settings, null) == null ? [] : [1]
      content {
        option = each.value.os_disk.diff_disk_settings.option
      }
    }
  }

  source_image_id = try(each.value.source_image_id, null)

  dynamic "plan" {
    for_each = try(each.value.plan, null) == null ? [] : [1]

    content {
      name      = each.value.plan.name
      publisher = each.value.plan.publisher
      product   = each.value.plan.product
    }
  }

  dynamic "source_image_reference" {
    for_each = try(each.value.source_image_reference, null) == null ? [] : [0]

    content {
      publisher = try(each.value.source_image_reference.publisher, null)
      offer     = try(each.value.source_image_reference.offer, null)
      sku       = try(each.value.source_image_reference.sku, null)
      version   = try(each.value.source_image_reference.version, null)
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "boot_diagnostics" {
    for_each = var.boot_diagnostics_storage_account == {} ? [] : [1]

    content {
      storage_account_uri = var.boot_diagnostics_storage_account
    }
  }

  lifecycle {
    # REFACTOR - Make this configurable
    ignore_changes = [instances]
  }
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
  for_each = local.create_sshkeys ? var.settings.scale_set_settings : {}

  name         = format("%s-ssh-private-key", azurecaf_name.linux[each.key].result)
  value        = tls_private_key.ssh[each.key].private_key_pem
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "ssh_public_key_openssh" {
  for_each = local.create_sshkeys ? var.settings.scale_set_settings : {}

  name         = format("%s-ssh-public-key-openssh", azurecaf_name.linux[each.key].result)
  value        = tls_private_key.ssh[each.key].public_key_openssh
  key_vault_id = local.keyvault.id

  lifecycle {
    ignore_changes = [
      value
    ]
  }
}