variable "location" {
  description = "The Azure Region for the state file storage"
  type        = string
  default     = "eastasia"
}

variable "project_prefix" {
  description = "A short prefix for your resources"
  type        = string
  default     = "terraland"
}