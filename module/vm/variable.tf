variable "vm_name" {
  description = "The name of the virtual machine."
  type        = string
}
variable "rg_name" {
  description = "The name of the resource group for the virtual machine."
  type        = string
}
variable "vm_location" {
  description = "The location of the resource group for the virtual machine."
  type        = string
}

variable "vm_size" {
  description = "The location of the resource group for the virtual machine."
  type        = any
}



variable "nic_id" {
  description = "The location of the resource group for the virtual machine."
  type        = string
}
variable "custom_data" {
  description = "Cloud-init script or custom data to be passed to the VM"
  type        = string
}

