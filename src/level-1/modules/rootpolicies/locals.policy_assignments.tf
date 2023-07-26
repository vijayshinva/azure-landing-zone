# The following locals are used to extract the Policy Assignment

locals {
  policy_assignment_json = tolist(fileset(path.module, "**/policy_assignment*.{json,json.tftpl}"))

  policy_assignments_dataset_from_json = try(length(local.policy_assignment_json) > 0, false) ? {
    for filepath in local.policy_assignment_json :
    filepath => jsondecode(templatefile("${path.module}/${filepath}", local.template_vars))
  } : null

  policy_assignments_map_from_json = try(length(local.policy_assignments_dataset_from_json) > 0, false) ? {
    for key, value in local.policy_assignments_dataset_from_json :
    value.name => value
  } : null
}
