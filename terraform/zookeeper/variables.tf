variable "aws_access_key" {
  # put your aws access key here
  default = ""
}
variable "aws_secret_key" {
  # put your aws secret key here
  default = ""
}

variable "key_name" {
  # put your aws ssh key here
  default = ""
}

variable "key_path" {
  # put path to that aws ssh here
  default = ""
}

variable "aws_region" {
  default = "us-west-1"
}

variable "availability_zones" {
  default = "us-east-1b,us-east-1d,us-east-1e"
}

variable "default_aws_amis" {
  default = {
    "us-east-1" = "ami-40d28157"
    "us-west-1" = "ami-6e165d0e"
  }
}

variable "zookeeper_count" {
  default = 1
}

variable "zookeeper_aws_amis" {
  default = {
    "us-east-1" = "ami-40d28157"
    "us-west-1" = "ami-6e165d0e"
  }
}

variable "kafka_count" {
  default = 1
}

variable "kafka_aws_amis" {
  default = {
    "us-east-1" = "ami-40d28157"
    "us-west-1" = "ami-6e165d0e"
  }
}

variable "instance_type" {
  default = "t2.medium"
}