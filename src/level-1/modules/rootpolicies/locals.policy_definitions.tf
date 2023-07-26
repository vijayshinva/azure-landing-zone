# The following locals are used to extract the Policy Definition

locals {
  policy_definition_json = tolist(fileset(path.module, "**/policy_definition*.{json,json.tftpl}"))

  policy_definitions_dataset_from_json = try(length(local.policy_definition_json) > 0, false) ? {
    for filepath in local.policy_definition_json :
    filepath => jsondecode(templatefile("${path.module}/${filepath}", local.template_vars))
  } : null

  policy_definitions_map_from_json = try(length(local.policy_definitions_dataset_from_json) > 0, false) ? {
    for key, value in local.policy_definitions_dataset_from_json :
    value.name => value
  } : null
}
