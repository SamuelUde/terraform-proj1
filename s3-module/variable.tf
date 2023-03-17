variable "name" {
  type    = string
  default = "samude"
}

variable "acl" {
  type    = string
  default = "private"
}

variable "versioning" {
  type    = string
  default = "Enabled"
}

variable "mykey_expiring" {
  type    = number
  default = "10"
}

variable "region" {
  type    = string
  default = "eu-north-1"
}