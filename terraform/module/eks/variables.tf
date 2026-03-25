variable "project_name" {}

variable "subnet_ids" {
  type = list(string)
}

variable "desired_size" {}

variable "max_size" {}

variable "min_size" {}

variable "env" {
  default = "dev"
}