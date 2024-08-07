# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


locals  {
    resource_group_name = "appreg-resources"
    location = "West Europe"
    virtualnetwork ={ 
        name = "example-network"
        address_space = "10.0.0.0/16"
    }
    subnet = {
        name =["subnet1","subnet2"]
        address_prefix = ["10.0.1.0/24","10.0.2.0/24"]
    }
}

# Create a resource group
resource "azurerm_resource_group" "appreg" {
  name     = local.resource_group_name
  location = local.location
}

resource "azurerm_virtual_network" "example" {
  name                = local.virtualnetwork.name
  location            = local.location
  resource_group_name = local.resource_group_name
  address_space       = [local.virtualnetwork.address_space]
  


  subnet {
    name           = local.subnet.name[0]
    address_prefix = local.subnet.address_prefix[0]
  }


  subnet {
    name           = local.subnet.name[1]
    address_prefix = local.subnet.address_prefix[1]
  }
 depends_on = [ azurerm_resource_group.appreg ]
}
