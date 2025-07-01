variable "server-name" {
    type = string
    description = "the name of the server"
}
variable "rg_name" {}
variable "location" {}
variable "sql_user" {
    type = string
    description = "the user name of sql server"
}
variable "sql_pass" {
    type = string
    description = "the password of the  sql server"
}