resource "azurerm_resource_group" "myrg-0611" {
  for_each = var.looping-vm
  name     = each.value.resource_group_name
  location = each.value.location
}

resource "azurerm_virtual_network" "myvnet-0611" {
  depends_on          = [azurerm_resource_group.myrg-0611]
  for_each            = var.looping-vm
  name                = each.value.vnet-name
  address_space       = each.value.address_space
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_subnet" "frontend-subnet0611" {
  depends_on           = [azurerm_virtual_network.myvnet-0611]
  for_each             = var.looping-vm
  name                 = each.value.subnet-name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet-name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_public_ip" "rocket-pip0611" {
  depends_on          = [azurerm_resource_group.myrg-0611]
  for_each            = var.looping-vm
  name                = each.value.pip-name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "rocket-nic0611" {
  depends_on          = [azurerm_public_ip.rocket-pip0611, azurerm_subnet.frontend-subnet0611]
  for_each            = var.looping-vm
  name                = each.value.nic-name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.frontend-subnet0611[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.rocket-pip0611[each.key].id
  }
}

resource "azurerm_linux_virtual_machine" "frontend-vm0611" {
  depends_on                      = [azurerm_network_interface.rocket-nic0611]
  for_each                        = var.looping-vm
  name                            = each.value.vm-name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.rocket-nic0611[each.key].id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}