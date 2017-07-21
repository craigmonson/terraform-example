provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.ami_name_filter}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_vpc" "tf_test" {
  cidr_block = "${var.vpc_cidr_block}"

  tags {
    Name = "tf_test"
  }
}

resource "aws_internet_gateway" "tf_test" {
  vpc_id = "${aws_vpc.tf_test.id}"

  tags {
    Name = "tf_test"
  }
}

resource "aws_subnet" "tf_test" {
  vpc_id                  = "${aws_vpc.tf_test.id}"
  cidr_block              = "${var.vpc_cidr_block}"
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true

  tags {
    Name = "tf_test"
  }
}

resource "aws_route_table" "tf_test" {
  vpc_id = "${aws_vpc.tf_test.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.tf_test.id}"
  }

  tags {
    Name = "tf_test"
  }
}

resource "aws_route_table_association" "tf_test" {
  subnet_id      = "${aws_subnet.tf_test.id}"
  route_table_id = "${aws_route_table.tf_test.id}"
}

resource "aws_key_pair" "tf_test" {
  key_name   = "tf-test"
  public_key = "${var.public_key}"
}

## INSTANCE ##
resource "aws_security_group" "tf_test" {
  name        = "allow_ssh"
  description = "allow ssh into, all out"
  vpc_id      = "${aws_vpc.tf_test.id}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 8080
    protocol    = "tcp"
    to_port     = 8080
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }

  tags {
    Name = "tf_test"
  }
}

resource "aws_instance" "tf_test" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${aws_key_pair.tf_test.key_name}"
  subnet_id              = "${aws_subnet.tf_test.id}"
  vpc_security_group_ids = ["${aws_security_group.tf_test.id}"]

  depends_on = ["aws_internet_gateway.tf_test"]
}
