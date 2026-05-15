looping-vm = {
  vm1 = {
    resource_group_name = "rocket-rg"
    location            = "central india"
    vnet-name           = "rocket-vnet"
    address_space       = ["10.0.0.0/16"]
    subnet-name         = "frontend-subnet"
    address_prefixes    = ["10.0.2.0/24"]
    pip-name            = "rocket-pip"
    nic-name            = "rocket-nic"
    vm-name             = "frontend-vm"
    size                = "Standard_D2s_v3"
    admin_username      = "krishna0611"
    admin_password      = "Password@0611"
  }

  vm2 = {
    resource_group_name = "rocket-rg"
    location            = "central india"
    vnet-name           = "rocket-vnet"
    address_space       = ["10.0.0.0/16"]
    subnet-name         = "frontend-subnet"
    address_prefixes    = ["10.0.2.0/24"]
    pip-name            = "rocket-pip2"
    nic-name            = "rocket-nic2"
    vm-name             = "frontend-vm2"
    size                = "Standard_D2s_v3"
    admin_username      = "krishna0611"
    admin_password      = "Password@0611"
  }
}