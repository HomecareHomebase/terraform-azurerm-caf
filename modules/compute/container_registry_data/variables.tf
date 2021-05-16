variable global_settings {
  description = "Global settings object (see module README.md)"
}
variable client_config {
  description = "Client configuration object (see module README.md)."
}

variable name {
  type        = string
  description = "(Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created."
}

variable resource_group_name {
  description = "(Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created."
}