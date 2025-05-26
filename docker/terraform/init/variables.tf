variable "kong_admin_username" {
  type    = string
  default = "kong"
}

variable "kong_admin_password" {
  type    = string
  default = "kong"
}

variable "kong_admin_uri" {
  type    = string
  default = "http://dkq-kong:8001"
}