variable "instance_type" {
  type        = string
  default = "t3.micro"
}

locals {
  ami = "ami-0aba19e56f3eaec05"
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}