output "vpc_id" {
  value = "${aws_vpc.tf_test.id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.tf_test.id}"
}

output "route_table_id" {
  value = "${aws_route_table.tf_test.id}"
}

output "subnet_id" {
  value = "${aws_subnet.tf_test.id}"
}

output "key_pair_name" {
  value = "${aws_key_pair.tf_test.key_name}"
}

output "security_group_id" {
  value = "${aws_security_group.tf_test.id}"
}

output "sg_ingress" {
  value = "${aws_security_group.tf_test.ingress}"
}

output "sg_egress" {
  value = "${aws_security_group.tf_test.egress}"
}

output "instance_id" {
  value = "${aws_instance.tf_test.id}"
}

output "public_ip" {
  value = "${aws_instance.tf_test.public_ip}"
}
