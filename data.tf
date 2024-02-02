data "azurerm_subnet" "bastion_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resourcegroup_name
}