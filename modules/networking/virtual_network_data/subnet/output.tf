
output id {
  value = data.azurerm_subnet.subnet.id

}

output name {
  value = data.azurerm_subnet.subnet.name

}

output cidr {
  value = data.azurerm_subnet.subnet.address_prefixes

}