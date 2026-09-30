Create a custom VPC with one public and one private subnet, set up the correct routing for internet access, and deploy EC2 instances across them.

Tasks

1. Create the VPC

Custom VPC (e.g. 10.0.0.0/16)

One public subnet

One private subnet

2. Internet Access

Create and attach an Internet Gateway

Create an Elastic IP

Create a NAT Gateway in the public subnet

3. Route Tables

Public route table → default route via IGW

Private route table → default route via NAT Gateway

4. EC2 Instances

Public EC2: launch in public subnet with public IP

Private EC2: launch in private subnet without public IP

5. Security

Public EC2 SG: allow SSH/HTTP only from your IP

Private EC2 SG: allow only internal access (e.g. from public EC2 or Bastion host)

Bonus (Optional)

Deploy a Bastion Host to access the private EC2

Enable CloudWatch monitoring on instances

Document your setup and take clear screenshots.
