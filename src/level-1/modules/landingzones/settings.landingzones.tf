# Configure custom landing zone resources settings
locals {
  custom_landing_zones = {
    "${var.root_id}" = {
      display_name               = "${lower(var.root_name)}"
      parent_management_group_id = "${data.azurerm_client_config.current.tenant_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_root"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-decommissioned" = {
      display_name               = "${lower(var.root_id)}-decommissioned"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_decommissioned"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-platform" = {
      display_name               = "${lower(var.root_id)}-platform"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_platform"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-connectivity" = {
      display_name               = "${lower(var.root_id)}-security"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-management" = {
      display_name               = "${lower(var.root_id)}-management"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_management"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-identity" = {
      display_name               = "${lower(var.root_id)}-identity"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_identity"
        parameters     = {}
        access_control = {}
      }
    }
    ##### landing zone #####
    "${var.root_id}-landing-zones" = {
      display_name               = "${lower(var.root_id)}-landing-zones"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_landing_zones"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-prod" = {
      display_name               = "${lower(var.root_id)}-org1"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-nonprod" = {
      display_name               = "${lower(var.root_id)}-org2"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-org1-dev" = {
      display_name               = "${lower(var.root_id)}-org1-non-prod"
      parent_management_group_id = "${lower(var.root_id)}-org1"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "non_prod"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-qa" = {
      display_name               = "${lower(var.root_id)}-org1-prod"
      parent_management_group_id = "${lower(var.root_id)}-org1"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "prod"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-uat" = {
      display_name               = "${lower(var.root_id)}-org1-connectivity"
      parent_management_group_id = "${lower(var.root_id)}-org1"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_connectivity"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-org1-dev" = {
      display_name               = "${lower(var.root_id)}-org2-non-prod"
      parent_management_group_id = "${lower(var.root_id)}-org2"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "non_prod"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-qa" = {
      display_name               = "${lower(var.root_id)}-org2-prod"
      parent_management_group_id = "${lower(var.root_id)}-org2"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "prod"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-uat" = {
      display_name               = "${lower(var.root_id)}-org2-connectivity"
      parent_management_group_id = "${lower(var.root_id)}-org2"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_connectivity"
        parameters     = {}
        access_control = {}
      }
    }
    ##### SandBox #####
    "${var.root_id}-sandboxes" = {
      display_name               = "${lower(var.root_id)}-sandboxes"
      parent_management_group_id = "${var.root_id}"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "es_sandboxes"
        parameters     = {}
        access_control = {}
      }
    }
  }
}
