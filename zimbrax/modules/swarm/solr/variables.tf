variable "vpc_id"               { type = "string" }
variable "private_subnet_ids"   { type = "list" }
variable "deployer_key_pair_id" { type = "string" }
variable "r53_zone_id"          { type = "string" }
variable "file_system_id"       { type = "string" }

variable "cache_security_group_id"       { type = "string" }
variable "swarm_security_group_id"       { type = "string" }
variable "db_security_group_id"          { type = "string" }
variable "file_system_security_group_id" { type = "string" }

variable "availability_zones" { type = "list" }
variable "user_public_keys"   { type = "list" }
variable "db_fqdn"            { type = "string" }

locals {
  environment  = "${terraform.workspace}"
  env_prefix_d = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}-"}"
  env_prefix_u = "${terraform.workspace == "prod" ? "" : "${terraform.workspace}_"}"

  vpc_id               = "${var.vpc_id}"
  private_subnet_ids   = "${var.private_subnet_ids}"
  deployer_key_pair_id = "${var.deployer_key_pair_id}"
  r53_zone_id          = "${var.r53_zone_id}"
  file_system_id       = "${var.file_system_id}"

  cache_security_group_id       = "${var.cache_security_group_id}"
  swarm_security_group_id       = "${var.swarm_security_group_id}"
  db_security_group_id          = "${var.db_security_group_id}"
  file_system_security_group_id = "${var.file_system_security_group_id}"
  

  availability_zones = "${var.availability_zones}"
  user_public_keys   = "${var.user_public_keys}"
  db_fqdn            = "${var.db_fqdn}"

  number_of_solr_nodes = 3
}
