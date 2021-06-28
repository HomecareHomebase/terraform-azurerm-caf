data "azurerm_container_registry" "acr" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
}