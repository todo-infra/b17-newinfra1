123
456
789




module "rg" {
  source      = "../module/rg"
  rg_name     = "kunj_rg3"
  rg_location = "malaysia west"
}
module "vnet" {
  source        = "../module/vnet"
  depends_on    = [module.rg]
  vnet_name     = "kunj_vnet3"
  address_space = ["10.0.0.0/16"]
  vnet_location = "malaysia west"
  rg_name       = "kunj_rg3"
}
module "frontend_subnet" {
  source           = "../module/subnet"
  depends_on       = [module.vnet]
  subnet_name      = "kunj_fsubnet3"
  rg_name          = "kunj_rg3"
  vnet_name        = "kunj_vnet3"
  address_prefixes = ["10.0.0.32/28"]
}
module "backend_subnet" {
  source           = "../module/subnet"
  depends_on       = [module.vnet]
  subnet_name      = "kunj_bsubnet3"
  rg_name          = "kunj_rg3"
  vnet_name        = "kunj_vnet3"
  address_prefixes = ["10.0.0.48/28"]
}
module "frontend_pip" {
  source             = "../module/pip"
  depends_on         = [module.rg]
  pip_name           = "kunj_fpip3"
  rg_name            = "kunj_rg3"
  pip_location       = "malaysia west"
  allocation_method  = "Dynamic"
  sku_basic_features = "Basic"
}
module "backend_pip" {
  source             = "../module/pip"
  depends_on         = [module.rg]
  pip_name           = "kunj_bpip3"
  rg_name            = "kunj_rg3"
  pip_location       = "malaysia west"
  allocation_method  = "Dynamic"
  sku_basic_features = "Basic"
}
module "frontend_nic" {
  source       = "../module/nic"
  depends_on   = [module.frontend_subnet]
  nic_name     = "kunj_fnic3"
  nic_location = "malaysia west"
  rg_name      = "kunj_rg3"
  subnet_name  = "kunj_fsubnet3"
  vnet_name    = "kunj_vnet3"
  pip_name     = "kunj_fpip3"
}
module "backend_nic" {
  source       = "../module/nic"
  depends_on   = [module.frontend_subnet]
  nic_name     = "kunj_bnic3"
  nic_location = "malaysia west"
  rg_name      = "kunj_rg3"
  subnet_name  = "kunj_bsubnet3"
  vnet_name    = "kunj_vnet3"
  pip_name     = "kunj_bpip3"
}
module "frontend_vm" {
  source         = "../module/vm"
  depends_on     = [module.frontend_nic]
  vm_name        = "kunj-fvm3"
  rg_name        = "kunj_rg3"
  vm_location    = "malaysia west"
  vm_size        = "Standard_B1s"
  admin_username = data.azurerm_key_vault_secret.vm-username.value
  admin_password = data.azurerm_key_vault_secret.vm-password.value
  nic_id         = module.frontend_nic.nic

  custom_data = base64encode(<<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y nginx
  systemctl enable nginx
  systemctl start nginx
EOF
)
}
module "backend_vm" {
  source         = "../module/vm"
  depends_on     = [module.backend_nic]
  vm_name        = "kunj-bvm3"
  rg_name        = "kunj_rg3"
  vm_location    = "malaysia west"
  vm_size        = "Standard_B1s"
  admin_username = data.azurerm_key_vault_secret.vm-username.value
  admin_password = data.azurerm_key_vault_secret.vm-password.value
  nic_id         = module.backend_nic.nic
}
module "sql_server" {
  source      = "../module/sql_server"
  server-name = "kunj-server"
  rg_name     = "kunj_rg3"
  location    = "malaysia west"
  sql_user    = "Ankur"
  sql_pass    = "Ankur@123456789!"
}
module "sql_database" {
  source      = "../module/sql_database"
  depends_on  = [module.sql_server]
  db_name     = "kunj_db"
  server-name = "kunj-server"
  rg_name     = "kunj_rg3"
}
