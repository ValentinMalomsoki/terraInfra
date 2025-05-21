# Resource Group
resource "azurerm_resource_group" "rg" {
location = "France Central"
name = "${var.namePre}-rg"
}

# Virtual Network
resource "azurerm_virtual_network" "my_terraform_network" {
name = "${random_pet.prefix.id}-vnet"
address_space = ["${var.baseAddress}/16"]
location = azurerm_resource_group.rg.location
resource_group_name = azurerm_resource_group.rg.name
}

# Subnet
resource "azurerm_subnet" "my_terraform_subnet" {
name = "${var.namePre}-subnet"
resource_group_name = azurerm_resource_group.rg.name
virtual_network_name = azurerm_virtual_network.my_terraform_network.name
address_prefixes = ["${var.baseAddress}/24"]
}

resource "random_pet" "prefix" {
length = 2
}

resource "azurerm_network_security_group" "secGroup" {
    name = "myGroup"
    location = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "secRule" {
    for_each = toset(var.openedPorts)
    name = "port-${each.key}"
    priority = 100 + each.key
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = each.key
    destination_port_range = each.key
    source_address_prefix = "*"
    destination_address_prefix = "*"
    resource_group_name = azurerm_resource_group.rg.name
    network_security_group_name = azurerm_network_security_group.secGroup.name
}

resource "azurerm_subnet_network_security_group_association" "sauce" {
  subnet_id                 = azurerm_subnet.my_terraform_subnet.id
  network_security_group_id = azurerm_network_security_group.secGroup.id
}
