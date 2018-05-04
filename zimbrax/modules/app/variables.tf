variable "vpc_id" {
  type = "string"
}

variable "r53_zone_id" {
  type = "string"
}

variable "public_subnet_ids" {
  type = "list"
}

variable "app_certificate_id" {
  type = "string"
}

variable "swarm_security_group_id" {
  type = "string"
}

variable "asg_workers_id" {
  type = "string"
}

locals {
  environment  = "${terraform.workspace}"
  env_prefix_d = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}-"}"
  env_prefix_u = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}_"}"

  vpc_id = "${var.vpc_id}"

  r53_zone_id = "${var.r53_zone_id}"

  public_subnet_ids  = "${var.public_subnet_ids}"
  app_certificate_id = "${var.app_certificate_id}"

  swarm_security_group_id = "${var.swarm_security_group_id}"

  asg_workers_id = "${var.asg_workers_id}"
}
