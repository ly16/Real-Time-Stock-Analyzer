variable "aws_access_key" {
  default = ""
}
variable "aws_secret_key" {
  default = ""
}

variable "key_name" {
  description = "Name of your AWS key pair"
  default = ""
}

variable "key_path" {
  description = "path to your private key file"
  default = ""
}