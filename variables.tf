variable "region" {
  type = "string"
}

variable "public_key" {
  type = "string"
}

variable "vpc_cidr_block" {
  type    = "string"
  default = "192.168.1.0/24"
}

variable "ami_name_filter" {
  default = "ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"
}

variable "instance_type" {
  default = "t2.micro"
}
