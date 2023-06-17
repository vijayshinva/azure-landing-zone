# Use variables to customize the deployment

variable "root_id" {
  type        = string
  description = "Sets the value used for generating unique resource naming within the module."
}

variable "root_name" {
  type        = string
  description = "Sets the value used for the organization within the module."
}
