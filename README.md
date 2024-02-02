# az_bastion



## Example usage 

Pour voir un exemple d'utilisation de ce module ce réferer au dossier "example".
Cloner le repot et effectuer un terraform init/plan/apply afin de voir un exemple de déploiement.

> ne pas oublier de faire un terraform destroy après avoir fait des tests

## Providers

| Name | Version |
|------|---------|
| [azurerm](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) | >= 3.11, < 4.0 |


## Modules

| Name |
|------|
| [public_ip_address](https://github.com/SebastienArthaud/az_public-ip-address.git) |


## Resources provisionés

| Name | Type |
|------|------|
| [azurerm_bastion_host](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/bastion_host) | resource |


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | nom du bastion à créer | `string` | null | yes |
| location | région e création de la resource | `string` | null | yes |
| resourcegroup_name | nom du groupe de ressource | `string` | null | yes |
| sku | sku du bastion (basic ou standard) | `string` | "Basic" | no |
| ip_connect_enabled | paramètre permettant de se connecter à une adresse IP privée spécifique depuis le Bastion (uniquement disponible avec le sku 'Standard') | `bool` | false | no |
| scale_units | Nombre d'instances de Bastion, default à 2. peut être modifié uniquement avec le sku 'Standard' | `number` | 2 | no |
| shareable_link_enabled | permet la connection à une machine en passant par un URL partagé par le Bastion (et pas par le portail AZURE) | `bool` | false | no |
| vnet_name | Nom du vnet dans lequel se trouvera le Bastion | `string` | null | yes |
| subnet_name | Nom du subnet dans lequel se trouvera le Bastion | `string` | null | yes |
| tags | Map des tags par défaut du bastion | `map(string)` | {} | no |


## Outputs

| Name | Description |
|------|-------------|
| bastion_id | ID du bastion créé |
| bastion_fqdn | fqdn du bastion créé |
