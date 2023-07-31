locals {
  configure_publicip_resources = {
    settings = {
      name                = "${var.settings.name}-pip"
      location            = var.settings.location
      resource_group_name = var.settings.resource_group_name
    }
  }
}

module "publicip" {
  source   = "../publicip"
  settings = local.configure_publicip_resources.settings
}

resource "azurerm_bastion_host" "this" {
  name                   = var.settings.name
  location               = var.settings.location
  resource_group_name    = var.settings.resource_group_name
  copy_paste_enabled     = var.settings.copy_paste_enabled
  file_copy_enabled      = var.settings.file_copy_enabled
  ip_connect_enabled     = var.settings.ip_connect_enabled
  shareable_link_enabled = var.settings.shareable_link_enabled
  tunneling_enabled      = var.settings.tunneling_enabled
  scale_units            = var.settings.scale_units

  ip_configuration {
    name                 = var.settings.ip_configuration.name
    subnet_id            = var.settings.ip_configuration.subnet_id
    public_ip_address_id = module.publicip.id
  }

  tags = merge(var.settings.default_tags, var.settings.tags)
}
