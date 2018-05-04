output "security_group_id" {
  value = "${aws_security_group.swarm.id}"
}

output "manager_instance_ids" {
  value = ["${aws_instance.manager.*.id}"]
}

output "manager_instance_ids_string" { 
  value = "${join(",", aws_instance.manager.*.id)}" 
}