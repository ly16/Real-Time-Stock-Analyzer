provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "zookeeper" {
  count = "${var.zookeeper_count}"
  ami = "${lookup(var.zookeeper_aws_amis, var.aws_region)}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.all-allow.name}"]
  key_name = "${var.key_name}"

  connection {
    user = "ubuntu"
    private_key = "${var.key_path}"
  }

  tags {
    Name = "zookeeper-${count.index}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get install -y python-minimal",
    ]
  }

  provisioner "local-exec" {
    command = "ansible -u ubuntu -m ping --private-key ${var.key_path} tag_Name_zookeeper* && ansible-playbook ../../ansible/zookeeper.yml --private-key ${var.key_path}"
  }
}

resource "aws_security_group" "all-allow" {
  name = "all-allow-sg"
  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}