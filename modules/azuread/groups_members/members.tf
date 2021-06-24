data "azuread_user" "upn" {
  for_each = toset(try(var.settings.members.user_principal_names, []))

  user_principal_name = each.value
}

module "user_principal_names" {
  source   = "./member"
  for_each = toset(try(var.settings.members.user_principal_names, []))

  group_object_id  = var.group_id
  member_object_id = data.azuread_user.upn[each.key].id
}


module "service_principals" {
  source   = "./member"
  for_each = toset(try(var.settings.members.service_principal_keys, []))

  group_object_id  = var.group_id
  member_object_id = var.azuread_apps[each.key].azuread_service_principal.object_id
}


module "object_id" {
  source   = "./member"
  for_each = toset(try(var.settings.members.object_ids, []))

  group_object_id  = var.group_id
  member_object_id = each.value
}

data "azuread_group" "name" {
  for_each = toset(try(var.settings.members.group_names, []))

  display_name = each.value
}

module "group_name" {
  source   = "./member"
  for_each = toset(try(var.settings.members.group_names, []))

  group_object_id  = var.group_id
  member_object_id = data.azuread_group.name[each.key].id
}

module "group_keys" {
  source   = "./member"
  for_each = toset(try(var.settings.members.group_keys, []))

  group_object_id  = var.group_id
  member_object_id = var.azuread_groups[each.key].id
}

module managed_identity_keys {
  source = "./member"
  for_each = toset(try(var.settings.members.managed_identity_keys, []))

  group_object_id  = var.group_id
  member_object_id = var.managed_identities[each.key].principal_id
}

# locals {
#   managed_identities_to_process = {
#       for mapping in
#       flatten(
#         [                                                                 # Variable
#           for lz_key, all_mi_mapping in try(var.settings.members.managed_identity_keys, {}) : [          #  built_in_role_mapping = {
#             for mi_key, mi_mapping in all_mi_mapping :
#             {
#               lz_key = lz_key
#               mi_key = mi_key
#               mi_id = var.managed_identities[lz_key][mi_key].id
#               group_id = var.group_id
#             }
#           ]
#         ]
#       ) : format("%s_%s_%s", mapping.group_id, mapping.lz_key, mapping.mi_key) => mapping
#     }


#   # managed_identities_to_process = {
#   #   for mapping in
#   #    flatten(
#   #     [                                                                 # Variable
#   #       for key_mode, all_role_mapping in var.role_mapping : [          #  built_in_role_mapping = {
#   #         for key, role_mappings in all_role_mapping : [                #       aks_clusters = {
#   #           for scope_key_resource, role_mapping in role_mappings : [   #         seacluster = {
#   #             for role_definition_name, resources in role_mapping : [   #           "Azure Kubernetes Service Cluster Admin Role" = {
#   #               for object_id_key, object_resources in resources : [    #             azuread_group_keys = {
#   #                 for object_id_key_resource in object_resources.keys : #               keys = [ "aks_admins" ] ----End of variable
#   #                 {                                                     # "seacluster_Azure_Kubernetes_Service_Cluster_Admin_Role_aks_admins" = {
#   #                   mode                    = key_mode                  #   "mode" = "built_in_role_mapping"
#   #                   scope_resource_key      = key
#   #                   scope_key_resource      = scope_key_resource
#   #                   role_definition_name    = role_definition_name
#   #                   object_id_resource_type = object_id_key
#   #                   object_id_key_resource  = object_id_key_resource #   "object_id_key_resource" = "aks_admins"
#   #                   lz_key                  = try(object_resources.lz_key, null)
#   #                 }
#   #               ]
#   #             ]
#   #           ]
#   #         ]
#   #       ]
#   #     ]
#   #   ) : format("%s_%s_%s", mapping.scope_key_resource, replace(mapping.role_definition_name, " ", "_"), mapping.object_id_key_resource) => mapping
#   # }
# }

# output debug_local_managed_identities_to_process {
#   value = {
#     managed_identities_to_process = local.managed_identities_to_process
#     managed_identities = var.managed_identities
#     members_managed_identity_keys = try(var.settings.members.managed_identity_keys, {})
#   }
# }