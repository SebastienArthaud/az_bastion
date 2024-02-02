module "az_bastion" {
  source                 = "../../az_bastion"
  name                   = var.name
  location               = data.azurerm_resource_group.data_resourcegroup.location
  resourcegroup_name     = var.resourcegroup_name
  sku                    = var.sku
  shareable_link_enabled = var.shareable_link_enabled
  subnet_name            = var.subnet_name
  vnet_name              = var.vnet_name
}