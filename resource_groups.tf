
module resource_groups {
  source   = "./modules/resource_group"
  for_each = var.resource_groups

  resource_group_name = each.value.name
  settings            = each.value
  global_settings     = local.global_settings
  tags                = var.tags
}

module "resource_group_datas" {
  source   = "./modules/resource_group_data"
  for_each = var.resource_group_datas

  resource_group_name = each.value.name
  settings            = each.value
  global_settings     = local.global_settings
  tags                = var.tags
}

output resource_groups {
  value     = merge(module.resource_groups, module.resource_group_datas)
  sensitive = true
}