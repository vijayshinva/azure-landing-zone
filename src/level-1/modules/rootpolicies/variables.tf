# Use variables to customize the deployment

variable "management_group_id" {
  type        = string
  description = "Sets the value used for Management Group."
}

variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
  default     = "centralindia"
}

variable "secondary_location" {
  type        = string
  description = "Sets the location for \"secondary\" resources to be created in."
  default     = "southindia"
}
