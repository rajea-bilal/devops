variable "instance_type" {
  type        = string
  default = "t3.small"
}

variable "ami" {
  type        = string
  default = "ami-0fd9576cca965bd19"
}

variable "region" {
  type        = string
  default = "eu-north-1"
}

variable "subnet_id" {
  type        = string
  default = "subnet-0400adbdca473db0b"
}


