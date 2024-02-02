variable "name" {
  type        = string
  description = "nom du bastion à créer"
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