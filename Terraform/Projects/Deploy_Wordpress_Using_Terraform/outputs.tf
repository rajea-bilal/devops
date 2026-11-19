output "public_ip" {
  description = "Public IP address of the WordPress server"
  value       = aws_instance.wordpress_hosted_ec2.public_ip
}