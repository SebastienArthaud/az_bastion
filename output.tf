output "bastion_id" {
  description = "ID du bastion créé"
  value       = resource.azurerm_bastion_host.az_bastion.id
}

output "bastion_fqdn" {
  description = "fqdn du bastion créé"
  value       = resource.azurerm_bastion_host.az_bastion.dns_name
}

output "bastion_subnet_id" {
  description = "ID du subnet dans lequel le bastion est créé"
  value       = data.azurerm_subnet.bastion_subnet.id
}

output "bastion_public_ip" {
  description = "IP publique du bastion"
  value       = module.public_ip_address.created_public_ip_address
}