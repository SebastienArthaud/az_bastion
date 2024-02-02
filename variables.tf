variable "name" {
  type        = string
  description = "nom du bastion à créer"
}

variable "location" {
  type        = string
  description = "région e création de la resource"
}

variable "resourcegroup_name" {
  type        = string
  description = "nom du groupe de ressource"
}

variable "sku" {
  type        = string
  description = "sku du bastion (basic ou standard)"
  default     = "basic"

  validation {
    condition     = var.sku == "Basic" || var.sku == "Standard"
    error_message = "La valeur du sku doit être 'Basic' ou 'Standard'"
  }
}

variable "ip_connect_enabled" {
  type        = bool
  description = "paramètre permettant de se connecter à une adresse IP privée spécifique depuis le Bastion (uniquement disponible avec le sku 'Standard')"
  default     = false
}

variable "scale_units" {
  type        = number
  description = "Nombre d'instances de Bastion, default à 2. peut être modifié uniquement avec le sku 'Standard'"
  default     = 2
}

variable "shareable_link_enabled" {
  type        = bool
  description = "permet la connection à une machine en passant par un URL partagé par le Bastion (et pas par le portail AZURE)"
  default     = false
}

variable "vnet_name" {
  type        = string
  description = "Nom du vnet dans lequel se trouvera le Bastion"
}

variable "subnet_name" {
  type        = string
  description = "Nom du subnet dans lequel se trouvera le Bastion"
}

variable "tags" {
  type        = map(string)
  description = "Map des tags par défaut du bastion"
  default     = {}
}