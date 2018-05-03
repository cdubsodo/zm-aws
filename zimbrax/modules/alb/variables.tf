variable "vpc_id" {
  type = "string"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "app_certificate_id" {
  type = "string"
}

variable "manager_instance_ids" {
  type = "list"
}

locals {
  environment  = "${terraform.workspace}"
  env_prefix_d = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}-"}"
  env_prefix_u = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}_"}"

  vpc_id               = "${var.vpc_id}"
  public_subnet_ids    = "${var.public_subnet_ids}"
  app_certificate_id   = "${var.app_certificate_id}"
  manager_instance_ids = "${var.manager_instance_ids}"
}
