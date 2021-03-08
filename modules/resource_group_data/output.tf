output name {
  value     = data.azurerm_resource_group.rg.name
  sensitive = true
}

output location {
  value     = data.azurerm_resource_group.rg.location
  sensitive = true
}

output tags {
  value     = data.azurerm_resource_group.rg.tags
  sensitive = true
}

output rbac_id {
  value = data.azurerm_resource_group.rg.id
}

output id {
  value = data.azurerm_resource_group.rg.id
}