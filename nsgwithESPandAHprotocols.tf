 terraform {
 required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "core"
  subscription_id = "71dbac3f-0c38-4127-833a-beb0f85925ad"
}


# This is required for resource modules
resource "azurerm_resource_group" "this" {
  location = "australiaeast"
  name     = "rg-tf_nsgesp"
}


resource "azurerm_network_security_group" "example" {
          name                = "my-nsg"
          location            = "australiaeast"
          resource_group_name = azurerm_resource_group.this.name
        }

#Esp port 500
resource "azurerm_network_security_rule" "allow_Esp" {
          name                        = "Allow_Esp"
          priority                    = 101
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Esp"
          source_port_range           = "*"
          destination_port_range      = "500"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
          network_security_group_name = azurerm_network_security_group.example.name
          resource_group_name         = azurerm_resource_group.this.name
        }

# Ah port 4500
resource "azurerm_network_security_rule" "allow_ah" {
          name                        = "Allow_ah"
          priority                    = 102
          direction                   = "Inbound"
          access                      = "Allow"
          protocol                    = "Ah"
          source_port_range           = "*"
          destination_port_range      = "4500"
          source_address_prefix       = "*"
          destination_address_prefix  = "*"
          network_security_group_name = azurerm_network_security_group.example.name
          resource_group_name         = azurerm_resource_group.this.name
        }
        