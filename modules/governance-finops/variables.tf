variable "resource_group_id" {
  description = "The ID of the Resource Group where this policy will apply."
  type = string
}
variable "allowed_vm_skus" {
  description = "A list of approved VM sizes"
  type = list(string)
}