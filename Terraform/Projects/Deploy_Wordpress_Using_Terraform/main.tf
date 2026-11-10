
// aws_instance is the official resource type defined by the AWS provider; it means an EC2 instance

resource "aws_instance" "wordpress_hosted_ec2" {
  ami                    = "ami-0fd9576cca965bd19"
  instance_type          = "t3.micro"
  subnet_id              = "subnet-0400adbdca473db0b"
  vpc_security_group_ids = [aws_security_group.wordpress_hosted.id]
  // because each instance could have multiple security groups, thats why we pass their ids as list items inside []
  user_data                   = file("user-data.sh")
  user_data_replace_on_change = true // replace the ec2 instance when user data changes
  tags = {
    Name = "WordpressHosted"
  }
}

// data = look up existing info
// default = true (select the vpc marked as default)
data "aws_vpc" "default_vpc" {
  default = true
}

// create a security group
resource "aws_security_group" "wordpress_hosted" {
  name        = "security group for hosted Wordpress"
  description = "Allot traffic over HTTP on port 80"
  vpc_id      = data.aws_vpc.default_vpc.id

  tags = {
    Name = "WordpressSecurityGroup"
  }
}

// incoming traffic rule for the security group
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.wordpress_hosted.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

// outgoing traffic rule for the security group
resource "aws_vpc_security_group_egress_rule" "allow_all_outgoing_traffic_ipv4" {
  security_group_id = aws_security_group.wordpress_hosted.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

// Allow outgoing connections to any ipv4 destination, using any protocol and port