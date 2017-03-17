provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami = "ami-0d729a60"
  instance_type = "t2.micro"

  connection {
    user = "ubuntu"
    private_key = "${var.key_path}"
  }

  key_name = "${var.key_name}"

  security_groups = ["${aws_security_group.webaccess.name}"]

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt-get install -y nginx",
    ]
  }
}

resource "aws_security_group" "webaccess" {
  name = "unclebarney"
  description = "security group rule to allow external access to 8080"

  # - allow ssh connection
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}