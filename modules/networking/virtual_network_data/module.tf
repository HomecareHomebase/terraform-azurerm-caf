// Creates the networks virtual network, the subnets and associated NSG, with a special section for AzureFirewallSubnet
# resource "azurecaf_name" "caf_name_vnet" {

#   name          = var.settings.vnet.name
#   resource_type = "azurerm_virtual_network"
#   prefixes      = [var.global_settings.prefix]
#   random_length = var.global_settings.random_length
#   clean_input   = true
#   passthrough   = var.global_settings.passthrough
#   use_slug      = var.global_settings.use_slug
# }

# resource "azurerm_virtual_network" "vnet" {
#   name                = azurecaf_name.caf_name_vnet.result
#   location            = var.location
#   resource_group_name = var.resource_group_name
#   address_space       = var.settings.vnet.address_space
#   tags                = local.tags

#   dns_servers = lookup(var.settings.vnet, "dns", null)

#   dynamic "ddos_protection_plan" {
#     for_each = var.ddos_id != "" ? [1] : []

#     content {
#       id     = var.ddos_id
#       enable = true
#     }
#   }
# }

data "azurerm_virtual_network" "vnet" {
  name                = var.settings.vnet.name
  resource_group_name = var.resource_group_name
}