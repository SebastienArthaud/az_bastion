locals {
  public_ip_address_name = "${var.name}_bastion_public_ip"
  ipconfig_name          = "${var.name}_ipconfig1"
  nsg_name               = "${var.name}_bastion_nsg"
}

module "public_ip_address" {
  source             = "github.com/SebastienArthaud/az_public-ip-address.git"
  resourcegroup_name = var.resourcegroup_name
  ip_name            = local.public_ip_address_name
  location           = var.location
}

module "az_network-security-group" {
  count              = var.create_nsg == true ? 1 : 0
  source             = "github.com/SebastienArthaud/az_network-security-group.git"
  resourcegroup_name = var.resourcegroup_name
  location           = var.location
  name               = local.nsg_name
  security_rule      = var.bastion_security_rule
  subnet_id          = data.azurerm_subnet.bastion_subnet.id

}


resource "azurerm_bastion_host" "az_bastion" {
  name                   = var.name
  location               = var.location
  resource_group_name    = var.resourcegroup_name
  sku                    = var.sku
  ip_connect_enabled     = var.sku == "Basic" ? false : var.ip_connect_enabled
  scale_units            = var.sku == "Basic" ? 2 : var.scale_units
  shareable_link_enabled = var.sku == "Basic" ? false : var.shareable_link_enabled
  tags                   = var.tags

  ip_configuration {
    name                 = local.ipconfig_name
    subnet_id            = data.azurerm_subnet.bastion_subnet.id
    public_ip_address_id = module.public_ip_address.created_public_ip_id
  }
}
