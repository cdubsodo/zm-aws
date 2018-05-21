variable "private_subnet_ids"      { type = "list" }
variable "app_certificate_id"      { type = "string" }
variable "manager_instance_ids"    { type = "list" }
variable "swarm_security_group_id" { type = "string" }


locals {
  environment  = "${terraform.workspace}"
  env_prefix_d = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}-"}"
  env_prefix_u = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}_"}"
  
  private_subnet_ids      = "${var.private_subnet_ids}"
  app_certificate_id      = "${var.app_certificate_id}"
  manager_instance_ids    = "${var.manager_instance_ids}"
  swarm_security_group_id = "${var.swarm_security_group_id}"
}
