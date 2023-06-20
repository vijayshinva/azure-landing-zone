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
 
     ##### platform #####
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


    "${var.root_id}-shared" = {
      display_name               = "${lower(var.root_id)}-Shared"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }

    "${var.root_id}-security" = {
      display_name               = "${lower(var.root_id)}-Security"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    
   "${var.root_id}-data" = {
      display_name               = "${lower(var.root_id)}-Data"
      parent_management_group_id = "${var.root_id}-platform"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
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
    "${var.root_id}-Zee5" = {
      display_name               = "${lower(var.root_id)}-Zee5"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
        parameters     = {}
        access_control = {}
      }
    }
    "${var.root_id}-zee-entertainment" = {
      display_name               = "${lower(var.root_id)}-Zee Entertainment"
      parent_management_group_id = "${var.root_id}-landing-zones"
      subscription_ids           = []
      archetype_config = {
        archetype_id   = "default_empty"
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
