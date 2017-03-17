output "web-public-dns" { value = "${aws_instance.web.public_dns}" }
output "web-public-ip"  { value = "${aws_instance.web.public_ip}" }