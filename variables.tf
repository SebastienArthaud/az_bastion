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

variable "create_nsg" {
  type        = bool
  default     = false
  description = "nsg à créer pour le bastion si besoin"
}

variable "bastion_security_rule" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_ranges    = list(string)
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "AllowHttpsInbound"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["443"]
      source_address_prefix      = "Internet"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowGatewayManagerInbound"
      priority                   = 130
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["443"]
      source_address_prefix      = "GatewayManager"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowAzureLoadBalancerInbound"
      priority                   = 140
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["443"]
      source_address_prefix      = "AzureLoadBalancer"
      destination_address_prefix = "*"
    },
    {
      name                       = "AllowBastionHostCommunication"
      priority                   = 150
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["8080", "5701"]
      source_address_prefix      = "VirtualNetwork"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowSshRdpOutbound"
      priority                   = 100
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["22", "3389"]
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowAzureCloudOutbound"
      priority                   = 110
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_ranges    = ["443"]
      source_address_prefix      = "*"
      destination_address_prefix = "AzureCloud"
    },
    {
      name                       = "AllowBastionCommunication"
      priority                   = 120
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["8080", "5701"]
      source_address_prefix      = "*"
      destination_address_prefix = "VirtualNetwork"
    },
    {
      name                       = "AllowHttpOutbound"
      priority                   = 130
      direction                  = "Outbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      destination_port_ranges    = ["80"]
      source_address_prefix      = "*"
      destination_address_prefix = "Internet"
    }
  ]
  description = "Règles de sécurité du NSG à créer"
}

variable "tags" {
  type        = map(string)
  description = "Map des tags par défaut du bastion"
  default     = {}
}