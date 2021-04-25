output debug {
    value = tomap({
        "local_services_roles" = try(local.services_roles, {}),
        "local_combined_objects_managed_identities" = try(local.combined_objects_managed_identities, {})
        # "custom_role_definitions" = module.custom_roles,
        # "roles_to_process" = local.roles_to_process,
        # "combined_objects_managed_identities" = local.combined_objects_managed_identities
        # "idents" = [
        #             for cluster in local.compute.aks_clusters:
        #             try(local.combined_objects_managed_identities[cluster.value.user_assigned_identity_lz_key][cluster.value.user_assigned_identity_managed_identity_key], {})
        #             ]
        # "azuread_groups_members_local_managed_identities_to_process" = module.azuread_groups_members
        # "combined_objects_azure_container_registries" = local.combined_objects_azure_container_registries
    })

    sensitive = true
}

# output debug_local_services_roles {
#   value = local.services_roles
#   sensitive = true
# }

# output debug_custom_role_definitions {
#   value = module.custom_roles
# }

# output debug_roles_to_process {
#   value = local.roles_to_process
# }

# output "debug_combined_objects_managed_identities" {
#   value = local.combined_objects_managed_identities
# }

# output "debug_idents" {
#   value = [
#     for cluster in local.compute.aks_clusters:
#       try(local.combined_objects_managed_identities[cluster.value.user_assigned_identity_lz_key][cluster.value.user_assigned_identity_managed_identity_key], {})
#   ]
# }

# output debug_azuread_groups_members_local_managed_identities_to_process {
#   value = module.azuread_groups_members
# }

# output debug_combined_objects_azure_container_registries {
#   value = local.combined_objects_azure_container_registries 
# }
