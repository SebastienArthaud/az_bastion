output "bastion_id" {
  description = "ID du bastion créé"
  value       = resource.azurerm_bastion_host.az_bastion.id
}

output "bastion_fqdn" {
  description = "fqdn du bastion créé"
  value       = resource.azurerm_bastion_host.az_bastion.dns_name
}